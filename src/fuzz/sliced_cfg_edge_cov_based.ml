open Util
module L = Logger
module F = Format
module CD = Coverage.Domain
module Coverage = CD.SancovEdgeCoverage
module SeedPool = Seedcorpus.Sliced_cfg_edge_cov_based
module Opt = Oracle.Optimizer (Coverage)
module Progress = CD.Progress (Coverage)

let choice () =
  let muts = Mutation.Domain.uniform_mutations in
  let idx = Random.int (Array.length muts) in
  muts.(idx)

let measure_optimizer_coverage selector llm =
  let open Oracle in
  let filename = F.sprintf "id:%010d.ll" (ALlvm.hash_llm llm) in
  let filename = ALlvm.save_ll !Config.out_dir filename llm in
  let optimized_ir_filename = AUtil.name_opted_ver filename in

  let optimization_res =
    Opt.run ~passes:!Config.optimizer_passes ~output:optimized_ir_filename
      filename
    |> Result.map
         selector (* this filters out irrelevant coverage information *)
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

let evalutate_mutant selector llm covset =
  let optim_res, _ = measure_optimizer_coverage selector llm in
  match optim_res with
  | Error _ -> None
  | Ok cov_mutant ->
      (* new edges are discovered? *)
      let new_points = Coverage.diff cov_mutant covset in
      let interesting = not @@ Coverage.is_empty new_points in
      if interesting then Some (llm, cov_mutant) else None

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
      if ALlvm.LLModuleSet.mem llset mutant then None
      else Some (SeedPool.Seed.make mutant)
  | Error _ -> None

let run selector seed_pool llctx llset progress =
  (* generate and deduplicate seeds *)
  let mutator = mutate_seed llctx llset in

  let rec generate_uniq_mutants times seed =
    if times = 0 then []
    else
      match mutator seed with
      | Some new_seed -> new_seed :: generate_uniq_mutants (times - 1) seed
      | None -> generate_uniq_mutants (times - 1) seed
  in

  let rec campaign pool (progress : Progress.t) =
    let seed, pool_popped = SeedPool.pop pool in
    let mutants = generate_uniq_mutants !Config.num_mutant seed in
    let interesting_mutants =
      mutants
      |> List.filter_map (fun mutant ->
             evalutate_mutant selector mutant progress.cov_sofar)
    in

    let new_progress =
      interesting_mutants
      |> List.map snd
      |> List.fold_left
           (fun prog cov -> prog |> Progress.add_cov cov |> Progress.inc_gen)
           progress
    in
    F.printf "progress: %a@." Progress.pp new_progress;

    let new_pool =
      interesting_mutants
      |> List.map fst
      |> List.fold_left
           (fun pool mutant -> SeedPool.push mutant pool)
           pool_popped
      |> SeedPool.push seed
    in

    interesting_mutants
    |> List.iter (fun (mutant, _) ->
           let llm = mutant in
           let seed_name = SeedPool.Seed.name mutant in
           ALlvm.save_ll !Config.corpus_dir seed_name llm |> ignore);

    campaign new_pool new_progress
  in

  campaign seed_pool progress
