open Util
module L = Logger
module F = Format
module Trace = Coverage.BlockTrace
module Opt = Oracle.Optimizer
module Progress = Coverage.Progress (Coverage.EdgeCoverage)

let choice () =
  let muts = Mutator.uniform_mutations in
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
  let optim_res, _ = measure_optimizer_coverage llm in
  L.debug "Mutant: ";
  L.debug "%s" (ALlvm.string_of_llmodule llm);
  match optim_res with
  | Error _ -> None
  | Ok lines ->
      let filter_func =
        match !Config.coverage with
        | Config.FuzzingMode.Sliced_cfg ->
            fun addr ->
              Coverage.sliced_cfg_node_of_addr node_tbl distance_map addr
              |> Option.is_some
        | _ -> fun _ -> true
      in
      let trace = lines |> List.map int_of_string |> List.filter filter_func in
      let cov = trace |> AUtil.pairs |> Coverage.EdgeCoverage.of_list in
      let new_points = Coverage.EdgeCoverage.diff cov covset in
      if Coverage.EdgeCoverage.is_empty new_points then
        prerr_endline "No new coverage points"
      else prerr_endline "New coverage points";
      let (new_seed : Seedpool.Seed.t) =
        Seedpool.Seed.make llm [ trace ] importants node_tbl distance_map
      in
      (if new_seed.covers then
         let seed_name =
           Seedpool.Seed.name ~parent:(ALlvm.hash_llm parent_llm) new_seed
         in
         ALlvm.save_ll !Config.covers_dir seed_name llm |> ignore);
      let interesting = not (Coverage.EdgeCoverage.is_empty new_points) in
      if interesting then Some new_seed else None
  | Assert _ -> None

let change_suffix filename suffix =
  let base = Filename.chop_suffix filename (Filename.extension filename) in
  base ^ suffix

let mutate_seed llctx llset seed =
  let muts = !Config.muts_dir in
  let seedfile =
    ALlvm.save_ll muts (F.sprintf "id:%010d.ll" (ALlvm.hash_llm seed)) seed
  in
  let mutant_file = change_suffix seedfile ".mut.ll" |> Filename.basename in
  let mut_parts = change_suffix seedfile ".mutated" in
  let llmutate_args =
    if !Config.mutation = Config.FuzzingMode.Uniform then
      [ "llmutate"; seedfile; muts; mutant_file; "-no-focus"; ">> log.txt" ]
    else [ "llmutate"; seedfile; muts; mutant_file; ">> log.txt" ]
  in

  AUtil.cmd llmutate_args |> ignore;

  let mutant = ALlvm.read_ll llctx (Filename.concat muts mutant_file) in
  match mutant with
  | Ok mutant when ALlvm.LLModuleSet.mem llset mutant -> None
  | Ok mutant ->
      let importants =
        In_channel.with_open_text mut_parts In_channel.input_all
      in
      Some (mutant, importants)
  | Error _ -> None

let update_progress progress seed =
  let cov_set = Seedpool.Seed.edge_cov seed in
  progress |> Progress.add_cov cov_set |> Progress.inc_gen

let rec try_gen_mutant mutator node_tbl distmap energy llm (prog : Progress.t) =
  if energy = 0 then None
  else
    match mutator llm with
    | Some (mutant, importants) -> (
        match
          evaluate_mutant llm mutant importants prog.cov_sofar node_tbl distmap
        with
        | Some new_seed -> Some new_seed
        | None ->
            try_gen_mutant mutator node_tbl distmap (energy - 1) mutant prog)
    | None -> try_gen_mutant mutator node_tbl distmap (energy - 1) llm prog

let gen_mutants mutator node_tbl distmap energy llm pool progress =
  let rec aux times pool progress =
    if times = 0 then (pool, progress)
    else
      match try_gen_mutant mutator node_tbl distmap energy llm progress with
      | Some new_seed ->
          let new_progress = update_progress progress new_seed in
          Seedpool.save ~parent:(ALlvm.hash_llm llm) new_seed;
          let new_pool = Seedpool.push new_seed pool in
          aux (times - 1) new_pool new_progress
      | None -> aux (times - 1) pool progress
  in
  aux energy pool progress

let run seed_pool node_tbl distmap llctx llset progress =
  (* generate and deduplicate seeds *)
  let mutator = mutate_seed llctx llset in

  let rec campaign pool (progress : Progress.t) =
    let seed, pool_popped = Seedpool.pop pool in
    let energy = Seedpool.Seed.get_energy seed in
    let llm = Seedpool.Seed.llmodule seed in
    AUtil.clean "importants";
    Out_channel.with_open_text "importants" (fun line ->
        Printf.fprintf line "%s" seed.importants);
    L.debug "campaign: seed popped (energy: %d): %a" energy Seedpool.Seed.pp
      seed;

    assert (energy >= 0);

    let new_pool, new_progress =
      gen_mutants mutator node_tbl distmap energy llm pool_popped progress
    in

    campaign (Seedpool.push seed new_pool) new_progress
  in

  campaign seed_pool progress
