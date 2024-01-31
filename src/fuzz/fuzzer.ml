open Util
module CD = Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
module OpCls = ALlvm.OpcodeClass
module F = Format

(** runs optimizer with an input file
    and measure its coverage.
    Returns the results *)
let measure_optimizer_coverage filename llm =
  let open Oracle in
  ALlvm.save_ll !Config.out_dir filename llm;
  let filename = Filename.concat !Config.out_dir filename in
  let optimized_ir_filename = AUtil.name_opted_ver filename in

  let optimization_res = Optimizer.run ~passes:optimizer_passes filename in

  if !Config.no_tv then (optimization_res, Validator.VALID)
  else
    let validation_res = Validator.run filename optimized_ir_filename in
    if validation_res <> Validator.VALID then
      ALlvm.save_ll !Config.crash_dir filename llm;
    AUtil.clean filename;
    AUtil.clean optimized_ir_filename;
    (optimization_res, validation_res)

let record_timestamp cov =
  (* timestamp *)
  let now = AUtil.now () in
  if now - !AUtil.recent_time > !Config.log_time then (
    AUtil.recent_time := now;
    F.sprintf "%d %d\n" (now - !AUtil.start_time) (CD.Coverage.cardinal cov)
    |> output_string AUtil.timestamp_fp)

let target_path = CD.Path.parse !Config.cov_directed

(* each mutant is mutated [Config.num_mutation] times *)
let rec mutate_seed llctx llset mode distance
    (pool, cov_sofar, gen_count, seed, times) =
  if times < 0 then invalid_arg "Expected nonnegative mutation times"
  else if times = 0 then (
    ALlvm.LLModuleSet.add llset seed ();
    (pool, cov_sofar, gen_count, seed, times))
  else
    let mutant = Mutator.run llctx mode seed distance in
    match ALlvm.LLModuleSet.get_new_name llset mutant with
    | None -> (pool, cov_sofar, gen_count + 1, seed, times)
    | Some filename -> (
        (* TODO: not using run result, only caring coverage *)
        let optim_res, _valid_res =
          measure_optimizer_coverage filename mutant
        in

        match optim_res with
        | INVALID | CRASH ->
            mutate_seed llctx llset mode distance
              (pool, cov_sofar, gen_count, seed, times)
        | VALID cov_mutant ->
            let mutant_score = CD.Coverage.score target_path cov_mutant in
            let covered = CD.Coverage.cover_target target_path cov_mutant in

            let mutant_score_int =
              Option.fold ~none:Int.max_int ~some:Fun.id mutant_score
            in

            (* induce new pool and coverage *)
            let pool', cov_set', gen_count, seed', times' =
              (* when mutated code cover target then push to queue *)
              if covered then (
                ALlvm.save_ll !Config.corpus_dir filename mutant;
                let pool =
                  SeedPool.push (mutant, covered, mutant_score_int) pool
                in
                (pool, cov_sofar, gen_count + 1, mutant, 0)
                (* when mutated code is closer to the target than before then push to queue *))
              else if mutant_score_int < distance then (
                ALlvm.save_ll !Config.corpus_dir filename mutant;
                let pool =
                  SeedPool.push (mutant, covered, mutant_score_int) pool
                in
                let cov_sofar = CD.Coverage.union cov_sofar cov_mutant in
                F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
                  (gen_count + 1)
                  (CD.Coverage.cardinal cov_sofar);
                (pool, cov_sofar, gen_count + 1, mutant, 0))
              else
                mutate_seed llctx llset mode distance
                  (pool, cov_sofar, gen_count, mutant, times - 1)
            in

            record_timestamp cov_set';

            (pool', cov_set', gen_count, seed', times'))

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx llset cov_set gen_count =
  let (seed, covered, distance), pool_popped = SeedPool.pop pool in
  let mode = if covered then Mutator.FOCUS else Mutator.EXPAND in

  (* each seed is mutated upto n mutants *)
  let pool', cov_set', gen_count, _, _ =
    AUtil.repeat_fun
      (mutate_seed llctx llset mode distance)
      (pool_popped, cov_set, gen_count, seed, !Config.num_mutation)
      !Config.num_mutant
  in
  let pool' = SeedPool.push (seed, covered, distance) pool' in

  (* repeat until the time budget or seed pool exhausts *)
  if
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  then cov_set'
  else run pool' llctx llset cov_set' gen_count
