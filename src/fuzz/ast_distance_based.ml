open Util
module L = Logger
module F = Format
module CD = Coverage.Domain
module MD = Mutation.Domain
module Coverage = CD.AstCoverage

let opc_tbl = ref MD.OpcodeMap.empty

let update_mut_tbl opcode_old opcode_new =
  let reward = !Config.learn_inc in
  match (opcode_old, opcode_new) with
  | Some opcode_old, Some opcode_new ->
      let new_tbl = MD.OpcodeMap.update opcode_old opcode_new reward !opc_tbl in
      opc_tbl := new_tbl;
      L.info "Updated TABLE:";
      L.info "%a" MD.OpcodeMap.pp !opc_tbl
  | _, _ -> ()

(** ast-distance fuzzing depends on seedpool policy: fifo or piority *)
module Make (SeedPool : Seedcorpus.Ast_distance_based.POOL) = struct
  module Seed = SeedPool.Seed
  module Dist = Seed.Distance
  module Progress = CD.Progress (Coverage)
  module Opt = Oracle.Optimizer

  let choice seed () =
    let mode = if Seed.covers seed then MD.FOCUS else EXPAND in
    let score = Seed.score seed |> Seed.Distance.to_int in
    Mutation.Mutator.choose_mutation mode score

  let measure_optimizer_coverage llm =
    let filename = F.sprintf "id:%010d.ll" (ALlvm.hash_llm llm) in
    let filename = ALlvm.save_ll !Config.out_dir filename llm in
    let optimized_ir_filename = AUtil.name_opted_ver filename in

    let optimization_res =
      Opt.run ~passes:!Config.optimizer_passes ~output:optimized_ir_filename
        filename
    in

    (if !Config.record_cov then
       try
         let cov_strings = AUtil.readlines !Config.cov_file in
         AUtil.update_numbers_with_cov !Config.json_file cov_strings
       with Sys_error _ -> ());

    if !Config.no_tv then (
      AUtil.clean filename;
      AUtil.clean optimized_ir_filename;
      (optimization_res, Oracle.Validator.Correct))
    else
      let validation_res =
        Oracle.Validator.run filename optimized_ir_filename
      in
      AUtil.clean filename;
      AUtil.clean optimized_ir_filename;
      (optimization_res, validation_res)

  type res_t =
    | Invalid
    | Interesting of bool * Seed.t * Progress.t
    | Not_interesting of bool * Seed.t

  let check_mutant mutant target_path (seed : Seed.t) progress =
    let optim_res, valid_res = measure_optimizer_coverage mutant in
    match optim_res with
    | Error _ -> Invalid
    | Ok lines_mutant ->
        let cov_mutant = Coverage.of_lines lines_mutant in
        let new_seed = Seed.make mutant target_path cov_mutant in
        L.debug "mutant: %a\n" Seed.pp new_seed;
        let is_crash = valid_res = Oracle.Validator.Incorrect in
        if Seed.closer seed new_seed then
          let progress =
            progress |> Progress.inc_gen |> Progress.add_cov cov_mutant
          in
          Interesting (is_crash, new_seed, progress)
        else Not_interesting (is_crash, new_seed)

  (* each mutant is mutated [Config.num_mutation] times *)
  let mutate_seed llctx target_path llset (seed : Seed.t) progress limit =
    (* assert (if not @@ seed.covers then seed.score > 0.0 else true); *)
    let learning = not !Config.no_learn in

    if learning then (
      L.debug "TABLE:";
      L.debug "%a" MD.OpcodeMap.pp !opc_tbl);

    let rec traverse times (src : Seed.t) progress =
      if times = 0 then (
        let llm = Seed.llmodule src in
        ALlvm.LLModuleSet.add llset llm ();
        None)
      else
        let opcode_old, opcode_new, dst =
          Mutation.Mutator.run llctx (Seed.llmodule src) (choice src)
        in
        match dst with
        | None ->
            (* mutator failed to find a proper mutation *)
            (* probably there is no chance to find a proper one ... deduct one iteration time *)
            traverse (times - 1) src progress
        | Some dst -> (
            match ALlvm.LLModuleSet.find_opt llset dst with
            | Some _ ->
                (* duplicate seed *)
                None
            | None -> (
                let parent = ALlvm.hash_llm (Seed.llmodule seed) in
                match check_mutant dst target_path src progress with
                | Interesting (is_crash, new_seed, new_progress) ->
                    let llm = Seed.llmodule new_seed in
                    ALlvm.LLModuleSet.add llset llm ();
                    (* update mutation table *)
                    if learning then update_mut_tbl opcode_old opcode_new;
                    let seed_name = Seed.name ~parent new_seed in
                    if is_crash then
                      ALlvm.save_ll !Config.crash_dir seed_name llm |> ignore
                    else
                      ALlvm.save_ll !Config.corpus_dir seed_name llm |> ignore;
                    Some (new_seed, new_progress)
                | Not_interesting (is_crash, new_seed) ->
                    let llm = Seed.llmodule new_seed in
                    (if is_crash then
                       let seed_name = Seed.name ~parent new_seed in
                       ALlvm.save_ll !Config.crash_dir seed_name llm |> ignore);
                    let new_mutant = Seed.overwrite src llm in
                    traverse (times - 1) new_mutant progress
                | Invalid -> traverse times src progress))
    in

    traverse limit seed progress

  (** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
  let rec run target_path pool llctx llset (progress : Progress.t) =
    let seed, pool_popped = SeedPool.pop pool in
    let mutator = mutate_seed llctx target_path llset in

    let llm = Seed.llmodule seed in
    L.debug "fuzz-hash: %d\n" (ALlvm.string_of_llmodule llm |> Hashtbl.hash);
    L.debug "fuzz-llm: %s\n" (ALlvm.string_of_llmodule llm);

    (* try generating interesting mutants *)
    (* each seed gets mutated upto n times *)
    let rec iter times (seeds, progress) =
      if times = 0 then (seeds, progress)
      else
        match mutator seed progress !Config.num_mutation with
        | Some (new_seed, new_progress) ->
            iter (times - 1) (new_seed :: seeds, new_progress)
        | None -> iter (times - 1) (seeds, progress)
    in

    let new_seeds, progress = iter !Config.num_mutant ([], progress) in
    F.printf "\r%a@?" Progress.pp progress;

    List.iter (L.info "[new_seed] %a" Seed.pp) new_seeds;
    let new_pool =
      new_seeds
      |> List.fold_left (fun pool seed -> SeedPool.push seed pool) pool_popped
      |> SeedPool.push seed
    in

    (* repeat until the time budget or seed pool exhausts *)
    let exhausted =
      !Config.time_budget > 0
      && AUtil.now () - !AUtil.start_time > !Config.time_budget
    in
    if exhausted then progress.cov_sofar
    else run target_path new_pool llctx llset progress
end
