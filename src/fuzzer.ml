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

let is_in_slice addr node_tbl distmap =
  if !Config.coverage = Config.FuzzingMode.Sliced_cfg then
    Coverage.node_of_addr node_tbl distmap addr |> Option.is_some
  else true

let log_new_points new_points =
  if Coverage.EdgeCoverage.is_empty new_points then
    L.debug "No new coverage points"
  else L.debug "New coverage points"

let save_if_cover parent_llm seed =
  if seed.Seedpool.CfgSeed.covers then
    let seed_name =
      Seedpool.Seed.name ~parent:(ALlvm.hash_llm parent_llm) seed
    in
    ALlvm.save_ll !Config.covers_dir seed_name seed.llm |> ignore

let compute_coverage_and_seed llm lines importants covset node_tbl distmap =
  let is_in_slice addr = is_in_slice addr node_tbl distmap in
  let trace = lines |> List.map int_of_string |> List.filter is_in_slice in
  let cov = trace |> AUtil.pairs |> Coverage.EdgeCoverage.of_list in
  let new_points = Coverage.EdgeCoverage.diff cov covset in
  let new_seed = Seedpool.Seed.make llm trace importants node_tbl distmap in
  (new_seed, new_points)

let evaluate_mutant parent_llm llm importants covset node_tbl distmap =
  let optim_res, _ = measure_optimizer_coverage llm in
  L.debug "Mutant:\n%s" (ALlvm.string_of_llmodule llm);
  match optim_res with
  | Ok lines ->
      let seed, new_points =
        compute_coverage_and_seed llm lines importants covset node_tbl distmap
      in
      log_new_points new_points;
      save_if_cover parent_llm seed;
      let interesting = not (Coverage.EdgeCoverage.is_empty new_points) in
      if interesting then Some seed else None
  | Error _ -> None
  | Assert _ -> None

let change_suffix filename suffix =
  let base = Filename.chop_suffix filename (Filename.extension filename) in
  base ^ suffix

let run_mutator llctx seed =
  let muts = !Config.muts_dir in
  let seedfile =
    ALlvm.save_ll muts (F.sprintf "id:%010d.ll" (ALlvm.hash_llm seed)) seed
  in
  let mutant_file = change_suffix seedfile ".mut.ll" |> Filename.basename in
  let llmutate_args =
    if !Config.mutation = Config.FuzzingMode.Uniform then
      [ "llmutate"; seedfile; muts; mutant_file; "-no-focus"; ">> log.txt" ]
    else [ "llmutate"; seedfile; muts; mutant_file; ">> log.txt" ]
  in

  AUtil.cmd llmutate_args |> ignore;

  match ALlvm.read_ll llctx (Filename.concat muts mutant_file) with
  | Ok mutant ->
      let mutated = change_suffix seedfile ".mutated" in
      let neighbors = In_channel.with_open_text mutated In_channel.input_all in
      Some (mutant, neighbors)
  | Error _ -> None

let mutate_seed llctx llset seed =
  match run_mutator llctx seed with
  | Some (mutant, neighbors) when not (ALlvm.LLModuleSet.mem llset mutant) ->
      Some (mutant, neighbors)
  | _ -> None

let update_progress progress seed =
  let cov_set = Seedpool.Seed.edge_cov seed in
  progress |> Progress.add_cov cov_set |> Progress.inc_gen

let rec try_gen_mutant mutator node_tbl distmap energy llm prog =
  if energy = 0 then None
  else
    match mutator llm with
    | Some (mutant, importants) -> (
        match
          evaluate_mutant llm mutant importants prog.Progress.cov_sofar node_tbl
            distmap
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

let save_importants seed =
  AUtil.clean "importants";
  Out_channel.with_open_text "importants" (fun line ->
      Printf.fprintf line "%s" seed.Seedpool.CfgSeed.importants)

let run seed_pool node_tbl distmap llctx llset progress =
  (* generate and deduplicate seeds *)
  let mutator = mutate_seed llctx llset in

  let rec campaign pool progress =
    let open Seedpool in
    let seed, pool_popped = pop pool in
    let energy = Seed.get_energy seed in
    let llm = Seed.llmodule seed in
    save_importants seed;
    L.debug "campaign: seed popped (energy: %d): %a" energy Seed.pp seed;

    assert (energy >= 0);

    let new_pool, new_progress =
      gen_mutants mutator node_tbl distmap energy llm pool_popped progress
    in

    campaign (Seedpool.push seed new_pool) new_progress
  in

  campaign seed_pool progress
