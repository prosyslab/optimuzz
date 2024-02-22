open Util
module CD = Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
module OpCls = ALlvm.OpcodeClass
module F = Format
module L = Logger

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
  let filename_full = Filename.concat !Config.out_dir filename in
  let optimized_ir_filename = AUtil.name_opted_ver filename_full in

  let optimization_res =
    Optimizer.run ~passes:optimizer_passes ~output:optimized_ir_filename
      filename_full
  in

  if !Config.no_tv then (
    AUtil.clean filename_full;
    AUtil.clean optimized_ir_filename;
    (optimization_res, Validator.Correct))
  else
    let validation_res = Validator.run filename_full optimized_ir_filename in
    if validation_res = Validator.Incorrect then
      ALlvm.save_ll !Config.crash_dir filename llm;
    AUtil.clean filename_full;
    AUtil.clean optimized_ir_filename;
    (optimization_res, validation_res)

let record_timestamp cov =
  (* timestamp *)
  let now = AUtil.now () in
  if now - !AUtil.recent_time > !Config.log_time then (
    AUtil.recent_time := now;
    F.sprintf "%d %d\n" (now - !AUtil.start_time) (CD.Coverage.cardinal cov)
    |> output_string AUtil.timestamp_fp)

type res_t =
  | Restart
  | Not_interesting
  | Interesting of SeedPool.seed_t * CD.Coverage.t

let check_mutant filename mutant target_path (seed : SeedPool.seed_t) =
  let score_func =
    match !Config.metric with
    | "avg" -> CD.Coverage.avg_score
    | "min" -> CD.Coverage.min_score
    | _ -> invalid_arg "Invalid metric"
  in
  (* TODO: not using run result, only caring coverage *)
  let optim_res, _valid_res = measure_optimizer_coverage filename mutant in
  match optim_res with
  | INVALID | CRASH -> Restart
  | VALID cov_mutant ->
      let new_seed : SeedPool.seed_t =
        let covered = CD.Coverage.cover_target target_path cov_mutant in
        let mutant_score =
          score_func target_path cov_mutant
          |> Option.fold
               ~none:(!Config.max_distance |> float_of_int)
               ~some:Fun.id
        in
        {
          priority = SeedPool.get_prio covered mutant_score;
          llm = mutant;
          covers = covered;
          score = mutant_score;
        }
      in
      L.debug "mutant score: %f, covers: %b\n" new_seed.score new_seed.covers;
      if new_seed.covers || ((not seed.covers) && new_seed.score < seed.score)
      then Interesting (new_seed, cov_mutant)
      else Not_interesting

(* each mutant is mutated [Config.num_mutation] times *)
let rec mutate_seed llctx target_path llset (seed : SeedPool.seed_t) progress
    times : (SeedPool.seed_t * Progress.t) option =
  assert (seed.score > 0.0);

  if times < 0 then invalid_arg "Expected nonnegative mutation times"
  else if times = 0 then (
    (* used up all allowed mutation times *)
    ALlvm.LLModuleSet.add llset seed.llm ();
    None)
  else
    let mutant = Mutator.run llctx seed in
    match ALlvm.LLModuleSet.get_new_name llset mutant with
    | None -> (* duplicated seed *) None
    | Some filename -> (
        match check_mutant filename mutant target_path seed with
        | Interesting (new_seed, cov_mutant) ->
            let progress =
              progress |> Progress.inc_gen |> Progress.add_cov cov_mutant
            in
            ALlvm.LLModuleSet.add llset new_seed.llm ();
            Some (new_seed, progress)
        | Restart -> mutate_seed llctx target_path llset seed progress times
        | Not_interesting ->
            mutate_seed llctx target_path llset { seed with llm = mutant }
              progress (times - 1))

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx llset progress =
  let seed, pool_popped = SeedPool.pop pool in
  let target_path = CD.Path.parse !Config.cov_directed |> Option.get in
  let mutator = mutate_seed llctx target_path llset in

  let seed_hash = ALlvm.string_of_llmodule seed.llm |> Hashtbl.hash in

  pool
  |> SeedPool.iter (fun seed ->
         L.debug "prio: %d, seed: %a" seed.priority SeedPool.pp_seed seed);
  L.debug "fuzz-hash: %010d\n" seed_hash;
  L.debug "fuzz-llm: %s\n" (ALlvm.string_of_llmodule seed.llm);

  (* try generating interesting mutants *)
  (* each seed gets mutated upto n times *)
  let rec iter times (seeds, progress) =
    if times = 0 then (seeds, progress)
    else
      match mutator seed progress !Config.num_mutation with
      | Some (new_seed, new_progress) ->
          iter (times - 1) (new_seed :: seeds, new_progress)
      | None -> iter (times - 1) (seeds, progress)
  in

  let new_seeds, progress = iter !Config.num_mutant ([], progress) in
  F.printf "\r%a %010d@?" Progress.pp progress seed_hash;

  (* here we know the actual ancestor seed *)
  List.iter
    (fun new_seed ->
      ALlvm.save_ll !Config.corpus_dir
        (SeedPool.name_seed ~parent:seed new_seed)
        seed.llm)
    new_seeds;

  List.iter (L.info "[new_seed] %a" SeedPool.pp_seed) new_seeds;
  let new_pool =
    pool_popped
    |> SeedPool.push_list new_seeds
    |> SeedPool.push { seed with priority = seed.priority + 1 }
  in

  (* repeat until the time budget or seed pool exhausts *)
  let exhausted =
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  in
  if exhausted then progress.cov_sofar else run new_pool llctx llset progress
