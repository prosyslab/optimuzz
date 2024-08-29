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
    Opt.run ~passes:!Config.optimizer_passes ~output:optimized_ir_filename
      filename
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

let evalutate_mutant llm covset node_tbl distance_map =
  let optim_res, _ = measure_optimizer_coverage llm in
  match optim_res with
  | Error _ -> None
  | Ok lines ->
      let traces =
        (* filter out nodes out of the sliced cfg *)
        Trace.of_lines lines
        |> List.map
             (List.filter (fun (addr : int) ->
                  let v = CD.Cfg.NodeTable.find addr node_tbl in
                  CD.Cfg.NodeMap.mem v distance_map))
      in
      let cov = Coverage.of_traces traces in
      let new_points = Coverage.diff cov covset in
      let (new_seed : SeedPool.Seed.t) =
        SeedPool.Seed.make llm traces node_tbl distance_map
      in
      (if new_seed.covers then
         let seed_name = SeedPool.Seed.name new_seed in
         ALlvm.save_ll !Config.covers_dir seed_name llm |> ignore);
      let interesting = not (Coverage.is_empty new_points) in
      if interesting then Some new_seed else None

let mutate_seed llctx llset seed =
  let muts = !Config.muts_dir in
  let seed_filename =
    ALlvm.save_ll muts (F.sprintf "id:%010d.ll" (ALlvm.hash_llm seed)) seed
  in
  let mut_filename = Filename.chop_suffix seed_filename ".ll" ^ ".mut.ll" in
  AUtil.cmd [ "./llmutate"; seed_filename; muts; mut_filename ] |> ignore;

  let mutant = ALlvm.read_ll llctx mut_filename in
  match mutant with
  | Ok mutant ->
      if ALlvm.LLModuleSet.mem llset mutant then None else Some mutant
  | Error _ -> None

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
      | Some mutated_llm -> (
          match
            evalutate_mutant mutated_llm progress.cov_sofar node_tbl distmap
          with
          | Some new_seed -> Some new_seed
          | None -> generate_mutant (energy - 1) mutated_llm progress)
      | None -> generate_mutant (energy - 1) llm progress
  in

  let rec generate_interesting_mutants times energy llm pool progress =
    if times = 0 then (pool, progress)
    else
      match generate_mutant energy llm progress with
      | Some new_seed ->
          let new_progress = update_progress progress new_seed in
          let new_pool = SeedPool.push new_seed pool in
          generate_interesting_mutants (times - 1) energy llm new_pool
            new_progress
      | None ->
          generate_interesting_mutants (times - 1) energy llm pool progress
  in

  let rec campaign pool (progress : Progress.t) =
    let seed, pool_popped = SeedPool.pop pool in
    let energy = SeedPool.Seed.get_energy seed in
    let llm = SeedPool.Seed.llmodule seed in
    L.debug "energy: %d" energy;

    let new_pool, new_progress =
      generate_interesting_mutants energy energy llm pool_popped progress
    in

    campaign (SeedPool.push seed new_pool) new_progress
  in

  campaign seed_pool progress
