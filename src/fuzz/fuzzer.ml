open Util
open Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
module OpCls = ALlvm.OpcodeClass
module F = Format

(** runs optimizer with an input file
    and measure its coverage.
    Returns the results *)
let measure_optimizer_coverage filename llm =
  let open Oracle in
  Coverage.Measurer.clean ();
  ALlvm.save_ll !Config.out_dir filename llm;
  let filename = Filename.concat !Config.out_dir filename in
  let optimized_ir_filename = AUtil.name_opted_ver filename in

  let optimization_res = Optimizer.run ~passes:optimizer_passes filename in
  let coverage =
    match optimization_res with
    | CRASH ->
        (* leave the maximum distance to the coverage set
           for later fuzzing steps to be able to use it as a reference *)
        DistanceSet.singleton !Config.max_distance
    | _ -> Coverage.Measurer.run ()
  in

  if !Config.no_tv then (optimization_res, VALID, coverage)
  else
    let validation_res = Validator.run filename optimized_ir_filename in
    if validation_res <> VALID then ALlvm.save_ll !Config.crash_dir filename llm;
    AUtil.clean filename;
    AUtil.clean optimized_ir_filename;
    (optimization_res, validation_res, coverage)

let record_timestamp distances =
  (* timestamp *)
  if AUtil.now () - !AUtil.recent_time > !Config.log_time then (
    AUtil.recent_time := AUtil.now ();
    output_string AUtil.timestamp_fp
      (string_of_int (AUtil.now () - !AUtil.start_time)
      ^ " "
      ^ string_of_int (DistanceSet.cardinal distances)
      ^ "\n"))

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx cov_set gen_count =
  let (seed, covered, distance), pool_popped = SeedPool.pop pool in
  let mode = if covered then Mutator.FOCUS else Mutator.EXPAND in

  (* each mutant is mutated [Config.num_mutation] times *)
  let rec mutate_seed (pool, cov_set, gen_count, seed, times) =
    if times = 0 then (
      AUtil.save_hash (ALlvm.string_of_llmodule seed);
      (pool, cov_set, gen_count, seed, times))
    else if times < 0 then invalid_arg "Expected nonnegative mutation times"
    else
      let mutant = Mutator.run llctx mode seed distance in
      let filename = AUtil.get_new_name (ALlvm.string_of_llmodule mutant) in
      (* if mutant is duplicated then just pass*)
      if filename = "" then (pool, cov_set, gen_count + 1, seed, times)
      else
        (* TODO: not using run result, only caring coverage *)
        let _optim_res, _valid_res, cov_mutant =
          measure_optimizer_coverage filename mutant
        in

        let mutant_score = DistanceSet.metric cov_mutant in
        (* check whether the seed is covering the target *)
        let covered =
          !Config.cov_directed <> "" && DistanceSet.cover_target cov_mutant
        in

        (* induce new pool and coverage *)
        let pool', cov_set', gen_count, seed', times' =
          (* when mutated code cover target then push to queue *)
          if covered then (
            ALlvm.save_ll !Config.corpus_dir filename mutant;
            let pool = SeedPool.push (mutant, covered, mutant_score) pool in
            (pool, cov_set, gen_count + 1, mutant, 0)
            (* when mutated code is closer to the target than before then push to queue *))
          else if mutant_score < distance then (
            ALlvm.save_ll !Config.corpus_dir filename mutant;
            let pool = SeedPool.push (mutant, covered, mutant_score) pool in
            let cov_set = DistanceSet.union cov_set cov_mutant in
            F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
              (gen_count + 1)
              (DistanceSet.cardinal cov_set);
            (pool, cov_set, gen_count + 1, mutant, 0))
          else mutate_seed (pool, cov_set, gen_count, mutant, times - 1)
        in

        record_timestamp cov_set';

        (pool', cov_set', gen_count, seed', times')
  in

  (* each seed is mutated upto n mutants *)
  let pool', cov_set', gen_count, _, _ =
    AUtil.repeat_fun mutate_seed
      (pool_popped, cov_set, gen_count, seed, !Config.num_mutation)
      !Config.num_mutant
  in
  let pool' = SeedPool.push (seed, covered, distance) pool' in

  (* repeat until the time budget or seed pool exhausts *)
  if
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  then cov_set'
  else run pool' llctx cov_set' gen_count
