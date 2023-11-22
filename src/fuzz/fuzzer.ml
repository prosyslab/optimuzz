open Util
open Coverage.Domain
module SeedPool = Seedcorpus.Seedpool

(* open Mutator *)
module OpCls = ALlvm.OpcodeClass
module F = Format

(** [run pool llctx cov_set get_count] pop seed from [pool] and mutate seed [Config.num_mutant] times. *)
let rec run pool llctx cov_set gen_count =
  let (seed, covered, distance), pool_popped = SeedPool.pop pool in
  let mode = if covered then Mutator.FOCUS else Mutator.EXPAND in

  (* each mutant is mutated m times *)
  let mutate_seed (pool, cov_set, gen_count) =
    let mutant = Mutator.run llctx mode !Config.num_mutation seed distance in
    let filename = AUtil.get_new_name () in
    (* TODO: not using run result, only caring coverage *)
    let _, cov_mutant = Oracle.run_bins filename mutant in
    let new_distance = CovSet.min_elt cov_mutant in
    (* check whether the seed is covering the target *)
    let covered = !Config.cov_directed <> "" && new_distance = 0 in

    (* induce new pool and coverage *)
    let pool', cov_set', gen_count =
      (* when mutated code cover target then push to queue *)
      if covered then (
        ALlvm.save_ll !Config.corpus_dir filename mutant;
        let pool = SeedPool.push (mutant, covered, new_distance) pool in
        (pool, cov_set, gen_count + 1)
        (* when mutated code is closer to the target than before then push to queue *))
      else if new_distance < distance then (
        ALlvm.save_ll !Config.corpus_dir filename mutant;
        let pool = SeedPool.push (mutant, covered, new_distance) pool in
        let cov_set = CovSet.union cov_set cov_mutant in
        F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
          (gen_count + 1) (CovSet.cardinal cov_set);
        (pool, cov_set, gen_count + 1))
      else (pool, cov_set, gen_count)
    in

    (* timestamp *)
    if AUtil.now () - !AUtil.recent_time > !Config.log_time then (
      AUtil.recent_time := AUtil.now ();
      output_string AUtil.timestamp_fp
        (string_of_int (AUtil.now () - !AUtil.start_time)
        ^ " "
        ^ string_of_int (CovSet.cardinal cov_set')
        ^ "\n"));
    (pool', cov_set', gen_count)
  in

  (* each seed is mutated into n mutants *)
  let pool', cov_set', gen_count =
    AUtil.repeat_fun mutate_seed
      (pool_popped, cov_set, gen_count)
      !Config.num_mutant
  in
  let pool' = SeedPool.push (seed, covered, distance) pool' in

  (* repeat until the time budget or seed pool exhausts *)
  if
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  then cov_set'
  else run pool' llctx cov_set' gen_count
