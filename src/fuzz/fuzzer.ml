open Util
module CD = Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
module OpCls = ALlvm.OpcodeClass
module F = Format

module Progress = struct
  type t = { cov_sofar : CD.Coverage.t; gen_count : int }

  let empty = { cov_sofar = CD.Coverage.empty; gen_count = 0 }
  let inc_gen p = { p with gen_count = p.gen_count + 1 }
  let add_cov cov p = { p with cov_sofar = CD.Coverage.union p.cov_sofar cov }
end

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
  if AUtil.now () - !AUtil.recent_time > !Config.log_time then (
    AUtil.recent_time := AUtil.now ();
    output_string AUtil.timestamp_fp
      (string_of_int (AUtil.now () - !AUtil.start_time)
      ^ " "
      ^ string_of_int (CD.Coverage.cardinal cov)
      ^ "\n"))

let target_path = CD.Path.parse !Config.cov_directed

(* each mutant is mutated [Config.num_mutation] times *)
let rec mutate_seed llctx llset mode best_score (pool, progress, seed, times) =
  if times < 0 then invalid_arg "Expected nonnegative mutation times"
  else if times = 0 then (
    (* used up all allowed mutation times *)
    ALlvm.LLModuleSet.add llset seed ();
    (pool, progress, seed, times))
  else
    let mutant = Mutator.run llctx mode seed best_score in
    match ALlvm.LLModuleSet.get_new_name llset mutant with
    | None ->
        (* fresh seed *)
        (pool, progress |> Progress.inc_gen, seed, times)
    | Some filename -> (
        (* TODO: not using run result, only caring coverage *)
        let optim_res, _valid_res =
          measure_optimizer_coverage filename mutant
        in
        match optim_res with
        | INVALID | CRASH ->
            mutate_seed llctx llset mode best_score (pool, progress, seed, times)
        | VALID cov_mutant ->
            let mutant_score = CD.Coverage.score target_path cov_mutant in
            let covered = CD.Coverage.cover_target target_path cov_mutant in
            let mutant_score_int =
              Option.fold ~none:Int.max_int ~some:Fun.id mutant_score
            in
            if covered then (
              ALlvm.save_ll !Config.corpus_dir filename mutant;
              let pool =
                SeedPool.push (mutant, covered, mutant_score_int) pool
              in
              record_timestamp progress.cov_sofar;
              (pool, progress |> Progress.inc_gen, mutant, 0))
            else if mutant_score_int < best_score then (
              ALlvm.save_ll !Config.corpus_dir filename mutant;
              let pool =
                SeedPool.push (mutant, covered, mutant_score_int) pool
              in
              let cov_sofar = CD.Coverage.union progress.cov_sofar cov_mutant in
              F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
                (progress.gen_count + 1)
                (CD.Coverage.cardinal cov_sofar);
              record_timestamp progress.cov_sofar;
              (pool, progress |> Progress.inc_gen, mutant, 0))
            else (
              record_timestamp progress.cov_sofar;
              mutate_seed llctx llset mode best_score
                (pool, progress, mutant, times - 1)))

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx llset progress =
  let (llm, covered, score), pool_popped = SeedPool.pop pool in
  let mode = if covered then Mutator.FOCUS else Mutator.EXPAND in

  (* each seed is mutated upto n mutants *)
  let pool', progress, _, _ =
    AUtil.repeat_fun
      (mutate_seed llctx llset mode score)
      (pool_popped, progress, llm, !Config.num_mutation)
      !Config.num_mutant
  in
  let pool' = SeedPool.push (llm, covered, score) pool' in

  (* repeat until the time budget or seed pool exhausts *)
  if
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  then progress.cov_sofar
  else run pool' llctx llset progress
