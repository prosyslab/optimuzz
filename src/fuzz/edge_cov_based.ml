open Util
module F = Format
module CD = Coverage.Domain
module MD = Mutation.Domain
module Coverage = CD.EdgeCoverage
module SeedPool = Seedcorpus.Edge_cov_based
module Opt = Oracle.Optimizer (Coverage)
module Progress = CD.Progress (Coverage)

let choice () =
  let muts = MD.uniform_mutations in
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

  (if !Config.record_cov then
     try
       let cov_strings = AUtil.read_lines !Config.cov_file in
       AUtil.update_numbers_with_cov !Config.json_file cov_strings
     with Sys_error _ -> ());

  if !Config.no_tv then (
    AUtil.clean filename;
    AUtil.clean optimized_ir_filename;
    (optimization_res, Validator.Correct))
  else
    let validation_res = Validator.run filename optimized_ir_filename in
    AUtil.clean filename;
    AUtil.clean optimized_ir_filename;
    (optimization_res, validation_res)

let evalutate_mutant mutant cov_sofar =
  let optim_res, _ = measure_optimizer_coverage mutant in
  match optim_res with
  | Error _ -> (false, Coverage.empty)
  | Ok cov_mutant ->
      (* new edges are discovered? *)
      let new_points = Coverage.diff cov_mutant cov_sofar in
      let interesting = not @@ Coverage.is_empty new_points in
      (interesting, cov_mutant)

let mutate_seed llctx llset choice seed =
  let open Util.AUtil in
  let llm = SeedPool.Seed.llmodule seed in
  let _, _, mutant = Mutation.Mutator.run llctx llm choice in
  let* mutant = mutant in
  match ALlvm.LLModuleSet.find_opt llset mutant with
  | Some _ -> None
  | None ->
      let new_seed = SeedPool.Seed.make mutant in
      Some new_seed

let run pool llctx llset progress =
  let mutator = mutate_seed llctx llset choice in
  (* try to make mutants up to [times] times *)
  let rec generate_mutants times seed =
    if times = 0 then []
    else
      match mutator seed with
      | Some new_seed -> new_seed :: generate_mutants (times - 1) seed
      | None -> generate_mutants (times - 1) seed
  in
  let rec campaign pool (progress : Progress.t) =
    let seed, pool_popped = SeedPool.pop pool in

    let mutants = generate_mutants !Config.num_mutant seed in

    let interesting_mutants =
      mutants
      |> List.map (fun mutant ->
             ( mutant,
               evalutate_mutant
                 (SeedPool.Seed.llmodule mutant)
                 progress.cov_sofar ))
      |> List.filter (fun (_, (interesting, _)) -> interesting)
      |> List.map (fun (mutant, (_, cov)) -> (mutant, cov))
    in

    let new_progress : Progress.t =
      interesting_mutants
      |> List.map snd
      |> List.fold_left
           (fun prog cov -> prog |> Progress.add_cov cov |> Progress.inc_gen)
           progress
    in
    F.printf "\r%a@?" Progress.pp new_progress;

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
           let llm = SeedPool.Seed.llmodule mutant in
           let seed_name = SeedPool.Seed.name mutant in
           ALlvm.save_ll !Config.corpus_dir seed_name llm |> ignore);

    campaign new_pool new_progress
  in

  campaign pool progress
