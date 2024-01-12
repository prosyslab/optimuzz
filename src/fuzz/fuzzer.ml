open Util
open Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
module OpCls = ALlvm.OpcodeClass
module F = Format

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
        let _, cov_mutant = Oracle.run_bins filename mutant in
        let new_distance = CovSet.min_elt cov_mutant in
        (* check whether the seed is covering the target *)
        let covered = !Config.cov_directed <> "" && new_distance = 0 in

        (* induce new pool and coverage *)
        let pool', cov_set', gen_count, seed', times' =
          (* when mutated code cover target then push to queue *)
          if covered then (
            ALlvm.save_ll !Config.corpus_dir filename mutant;
            let pool = SeedPool.push (mutant, covered, new_distance) pool in
            (pool, cov_set, gen_count + 1, mutant, 0)
            (* when mutated code is closer to the target than before then push to queue *))
          else if new_distance < distance then (
            ALlvm.save_ll !Config.corpus_dir filename mutant;
            let pool = SeedPool.push (mutant, covered, new_distance) pool in
            let cov_set = CovSet.union cov_set cov_mutant in
            F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
              (gen_count + 1) (CovSet.cardinal cov_set);
            (pool, cov_set, gen_count + 1, mutant, 0))
          else mutate_seed (pool, cov_set, gen_count, mutant, times - 1)
        in

        (* timestamp *)
        if AUtil.now () - !AUtil.recent_time > !Config.log_time then (
          AUtil.recent_time := AUtil.now ();
          output_string AUtil.timestamp_fp
            (string_of_int (AUtil.now () - !AUtil.start_time)
            ^ " "
            ^ string_of_int (CovSet.cardinal cov_set')
            ^ "\n"));
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
