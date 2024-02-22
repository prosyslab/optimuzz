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

let check_mutant (seed : SeedPool.seed_t) filename mutant target_path =
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
  | VALID cov -> (
      let covers = CD.Coverage.cover_target target_path cov in
      let score =
        score_func target_path cov
        |> Option.fold ~none:(!Config.max_distance |> float_of_int) ~some:Fun.id
      in
      let child : SeedPool.seed_t =
        {
          priority = SeedPool.get_prio covers score;
          llm = mutant;
          covers;
          score;
        }
      in
      L.debug "mutant score: %f, covers: %b\n" child.score child.covers;

      match seed with
      | { covers = true; _ } when child.covers -> Interesting (child, cov)
      | { covers = false; score; _ } when child.score < score || child.covers ->
          Interesting (child, cov)
      | _ -> Not_interesting)

(* each mutant is mutated [Config.num_mutation] times *)
let mutate_seed llctx target_path llset (seed : SeedPool.seed_t) progress limit
    :
    ( ALlvm.LLModuleSet.t,
      SeedPool.seed_t * Progress.t * ALlvm.LLModuleSet.t )
    Either.t =
  assert (seed.score > 0.0);

  (* explore LLVM IR space by mutating src to dst *)
  let rec traverse (src : SeedPool.seed_t) progress llset times =
    if times = 0 then ALlvm.LLModuleSet.add src.llm llset |> Either.left
    else
      let dst = Mutator.run llctx src in
      match ALlvm.LLModuleSet.get_new_name dst llset with
      | None -> llset |> Either.left
      | Some filename -> (
          match check_mutant seed filename dst target_path with
          | Interesting (new_seed, cov) ->
              assert (new_seed.llm == dst);
              assert (not @@ ALlvm.LLModuleSet.mem new_seed.llm llset);
              let progress =
                progress |> Progress.inc_gen |> Progress.add_cov cov
              in
              let seed_name = SeedPool.name_seed ~parent:seed new_seed in
              (* FIXME: some seeds are not saved... *)
              ALlvm.save_ll !Config.corpus_dir seed_name new_seed.llm;
              let new_set = ALlvm.LLModuleSet.add new_seed.llm llset in
              (new_seed, progress, new_set) |> Either.right
          | Restart -> traverse src progress llset times
          | Not_interesting ->
              traverse { src with llm = dst } progress llset (times - 1))
  in

  traverse seed progress llset limit

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx llset progress =
  let seed, pool_popped = SeedPool.pop pool in
  let target_path = CD.Path.parse !Config.cov_directed |> Option.get in
  let mutator = mutate_seed llctx target_path in

  (* try generating interesting mutants.
     each seed can have up to [n] descendant *)
  let rec children n (seeds, progress, llset) =
    if n = 0 then (seeds, progress, llset)
    else
      match mutator llset seed progress !Config.num_mutation with
      | Either.Right (new_seed, new_progress, llset) ->
          children (n - 1) (new_seed :: seeds, new_progress, llset)
      | Either.Left llset -> children (n - 1) (seeds, progress, llset)
  in

  let new_seeds, progress, llset =
    children !Config.num_mutant ([], progress, llset)
  in

  F.printf "\r%a\t%010d\t%d@?" Progress.pp progress (ALlvm.hash_llm seed.llm)
    (List.length new_seeds);

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
