open Util
module L = Logger
module F = Format
module CD = Coverage.Domain
module Coverage = CD.EdgeCoverage
module Trace = CD.BlockTrace
module SeedPool = Seedcorpus.Sliced_cfg_edge_cov_based
module Opt = Oracle.Optimizer
module Progress = CD.Progress (Coverage)

let choice () =
  let muts = Mutation.Domain.uniform_mutations in
  let idx = Random.int (Array.length muts) in
  muts.(idx)

let measure_optimizer_coverage llm =
  let open Oracle in
  let filename = F.sprintf "id:%010d.ll" (ALlvm.hash_llm llm) in
  let filename = ALlvm.save_ll !Config.out_dir filename llm in
  let optimized_ir_filename = AUtil.name_opted_ver filename in

  let optimization_res =
    Opt.run ~passes:!Config.optimizer_passes ~mtriple:!Config.mtriple
      ~output:optimized_ir_filename filename
  in

  if !Config.no_tv then (
    AUtil.clean filename;
    AUtil.clean optimized_ir_filename;
    (optimization_res, Validator.Correct))
  else
    let validation_res = Validator.run filename optimized_ir_filename in
    AUtil.clean filename;
    AUtil.clean optimized_ir_filename;
    (optimization_res, validation_res)

let evaluate_mutant parent_llm llm importants covset node_tbl distance_map =
  let get_traces lines =
    (* only use nodes in the sliced cfg *)
    Trace.of_lines lines
    |> List.map
         (List.filter (fun addr ->
              CD.sliced_cfg_node_of_addr node_tbl distance_map addr
              |> Option.is_some))
  in

  let optim_res, _ = measure_optimizer_coverage llm in
  L.debug "Mutant: ";
  L.debug "%s" (ALlvm.string_of_llmodule llm);
  match optim_res with
  | Error _ -> None
  | Ok lines ->
      let filter =
        match !Config.mode with
        | Config.Mode.Directed (true, _, _) -> true
        | _ -> false
      in
      let filter_func =
        if filter then fun addr ->
          CD.sliced_cfg_node_of_addr node_tbl distance_map addr
          |> Option.is_some
        else fun _ -> true
      in
      let trace = lines |> List.map int_of_string |> List.filter filter_func in
      let cov = trace |> AUtil.pairs |> Coverage.of_list in
      (* let traces = get_traces lines in
         let cov = Coverage.of_traces traces in *)
      let new_points = Coverage.diff cov covset in
      let (new_seed : SeedPool.Seed.t) =
        SeedPool.Seed.make llm [ trace ] importants node_tbl distance_map
      in
      (if new_seed.covers then
         let seed_name =
           SeedPool.Seed.name ~parent:(ALlvm.hash_llm parent_llm) new_seed
         in
         ALlvm.save_ll !Config.covers_dir seed_name llm |> ignore);
      let interesting = not (Coverage.is_empty new_points) in
      if interesting then Some new_seed else None
  | Assert _ (*lines*) ->
      (* let traces = get_traces lines in
         let (new_seed : SeedPool.Seed.t) =
           SeedPool.Seed.make llm traces node_tbl distance_map
         in
         let seed_name = SeedPool.Seed.name new_seed in
         ALlvm.save_ll !Config.crash_dir seed_name llm |> ignore; *)
      None

let mutate_seed llctx llset seed =
  let muts = !Config.muts_dir in
  let seed_filename =
    ALlvm.save_ll muts (F.sprintf "id:%010d.ll" (ALlvm.hash_llm seed)) seed
  in
  let mut_filename = Filename.chop_suffix seed_filename ".ll" ^ ".mut.ll" in
  let mutated_filename =
    Filename.chop_suffix seed_filename ".ll" ^ ".mutated"
  in
  AUtil.cmd [ "./llmutate"; seed_filename; muts; mut_filename; ">> log.txt" ]
  |> ignore;

  let mutant = ALlvm.read_ll llctx mut_filename in
  match mutant with
  | Ok mutant ->
      if ALlvm.LLModuleSet.mem llset mutant then ("", None)
      else
        let importants =
          In_channel.with_open_text mutated_filename In_channel.input_all
        in
        (importants, Some mutant)
  | Error _ -> ("", None)

let update_progress progress seed =
  let cov_set = SeedPool.Seed.edge_cov seed in
  progress |> Progress.add_cov cov_set |> Progress.inc_gen

let run seed_pool node_tbl distmap llctx llset progress =
  (* generate and deduplicate seeds *)
  let mutator = mutate_seed llctx llset in

  let rec generate_mutant energy llm (progress : Progress.t) =
    if energy = 0 then None
    else
      match mutator llm with
      | importants, Some mutated_llm -> (
          match
            evaluate_mutant llm mutated_llm importants progress.cov_sofar
              node_tbl distmap
          with
          | Some new_seed -> Some new_seed
          | None -> generate_mutant (energy - 1) mutated_llm progress)
      | _, None -> generate_mutant (energy - 1) llm progress
  in

  let generate_interesting_mutants energy llm pool progress =
    let rec aux times pool progress =
      if times = 0 then (pool, progress)
      else
        match generate_mutant energy llm progress with
        | Some new_seed ->
            let new_progress = update_progress progress new_seed in
            SeedPool.save ~parent:(ALlvm.hash_llm llm) new_seed;
            let new_pool = SeedPool.push new_seed pool in
            aux (times - 1) new_pool new_progress
        | None -> aux (times - 1) pool progress
    in
    aux energy pool progress
  in

  let rec campaign pool (progress : Progress.t) =
    let seed, pool_popped = SeedPool.pop pool in
    let energy = SeedPool.Seed.get_energy seed in
    let llm = SeedPool.Seed.llmodule seed in
    AUtil.clean "importants";
    Out_channel.with_open_text "importants" (fun line ->
        Printf.fprintf line "%s" seed.importants);
    L.debug "campaign: seed popped (energy: %d): %a" energy SeedPool.Seed.pp
      seed;

    assert (energy >= 0);

    let new_pool, new_progress =
      generate_interesting_mutants energy llm pool_popped progress
    in

    campaign (SeedPool.push seed new_pool) new_progress
  in

  campaign seed_pool progress
