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

  let pp fmt progress =
    F.fprintf fmt "generated: %d, coverage: %d" progress.gen_count
      (CD.Coverage.cardinal progress.cov_sofar)
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
  let now = AUtil.now () in
  if now - !AUtil.recent_time > !Config.log_time then (
    AUtil.recent_time := now;
    F.sprintf "%d %d\n" (now - !AUtil.start_time) (CD.Coverage.cardinal cov)
    |> output_string AUtil.timestamp_fp)

(* each mutant is mutated [Config.num_mutation] times *)
let rec mutate_seed llctx target_path llset (seed : SeedPool.seed_t) progress
    times : SeedPool.seed_t option * Progress.t =
  assert (seed.score > 0.0);

  if times < 0 then invalid_arg "Expected nonnegative mutation times"
  else if times = 0 then (
    (* used up all allowed mutation times *)
    ALlvm.LLModuleSet.add llset seed.llm ();
    (None, progress))
  else
    let mode = if seed.covers then Mutator.FOCUS else Mutator.EXPAND in
    let mutant = Mutator.run llctx mode seed.llm (int_of_float seed.score) in
    match ALlvm.LLModuleSet.get_new_name llset mutant with
    | None ->
        (* duplicated seed *)
        (None, progress)
    | Some filename -> (
        (* TODO: not using run result, only caring coverage *)
        let optim_res, _valid_res =
          measure_optimizer_coverage filename mutant
        in
        match optim_res with
        | INVALID | CRASH ->
            mutate_seed llctx target_path llset seed progress times
        | VALID cov_mutant ->
            let covered = CD.Coverage.cover_target target_path cov_mutant in
            let mutant_score =
              CD.Coverage.score target_path cov_mutant
              |> Option.fold
                   ~none:(!Config.max_distance |> float_of_int)
                   ~some:Fun.id
            in
            let new_seed : SeedPool.seed_t =
              { llm = mutant; covers = covered; score = mutant_score }
            in
            if covered || mutant_score < seed.score then (
              ALlvm.save_ll !Config.corpus_dir filename mutant;
              let progress =
                progress |> Progress.inc_gen |> Progress.add_cov cov_mutant
              in
              record_timestamp progress.cov_sofar;
              (Some new_seed, progress))
            else (
              record_timestamp progress.cov_sofar;
              mutate_seed llctx target_path llset seed progress (times - 1)))

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx llset progress =
  let seed, pool_popped = SeedPool.pop pool in
  let target_path = CD.Path.parse !Config.cov_directed in
  let mutator = mutate_seed llctx target_path llset in

  (* try generating interesting mutants *)
  (* each seed gets mutated upto n times *)
  let rec iter times (seeds, progress) =
    if times = 0 then (seeds, progress)
    else
      let new_seed, new_progress = mutator seed progress !Config.num_mutation in
      iter (times - 1) (new_seed :: seeds, new_progress)
  in

  let new_seeds, progress = iter !Config.num_mutant ([], progress) in
  F.printf "\r%a@?" Progress.pp progress;

  let new_seeds = List.filter_map Fun.id new_seeds in
  List.iter (F.eprintf "%a\n" SeedPool.pp_seed) new_seeds;
  let new_pool =
    pool_popped
    |> SeedPool.push_seq (new_seeds |> List.to_seq)
    |> SeedPool.push seed
  in

  (* repeat until the time budget or seed pool exhausts *)
  let exhausted =
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  in
  if exhausted then progress.cov_sofar else run new_pool llctx llset progress
