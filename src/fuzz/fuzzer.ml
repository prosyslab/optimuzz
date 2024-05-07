open Util
module CD = Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
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

type res_t =
  | Invalid
  | Interesting of bool * SeedPool.seed_t * Progress.t
  | Not_interesting of bool * SeedPool.seed_t

(** runs optimizer with an input file
    and measure its coverage.
    Returns the results *)
let measure_optimizer_coverage llm =
  let open Oracle in
  let filename = F.sprintf "id:%010d.ll" (ALlvm.hash_llm llm) in
  let filename = ALlvm.save_ll !Config.out_dir filename llm in
  let optimized_ir_filename = AUtil.name_opted_ver filename in

  let optimization_res =
    Optimizer.run ~passes:!Config.optimizer_passes ~output:optimized_ir_filename
      filename
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

let record_timestamp cov =
  (* timestamp *)
  let now = AUtil.now () in
  if now - !AUtil.recent_time > !Config.log_time then (
    AUtil.recent_time := now;
    F.sprintf "%d %d\n" (now - !AUtil.start_time) (CD.Coverage.cardinal cov)
    |> output_string AUtil.timestamp_fp)

let check_mutant mutant target_path (seed : SeedPool.seed_t) progress =
  let score_func =
    match !Config.metric with
    | Avg -> CD.Coverage.avg_score
    | Min -> CD.Coverage.min_score
  in
  let optim_res, valid_res = measure_optimizer_coverage mutant in
  match optim_res with
  | INVALID | CRASH -> Invalid
  | VALID cov_mutant ->
      let new_seed : SeedPool.seed_t =
        let covers = CD.Coverage.cover_target target_path cov_mutant in
        let score =
          score_func target_path cov_mutant
          |> Option.value ~default:(!Config.max_distance |> float_of_int)
        in
        let priority = SeedPool.get_prio covers score in
        { priority; llm = mutant; covers; score }
      in
      L.debug "mutant score: %f, covers: %b\n" new_seed.score new_seed.covers;
      let is_crash = valid_res = Oracle.Validator.Incorrect in
      if new_seed.covers || ((not seed.covers) && new_seed.score < seed.score)
      then
        let progress =
          progress |> Progress.inc_gen |> Progress.add_cov cov_mutant
        in
        Interesting (is_crash, new_seed, progress)
      else Not_interesting (is_crash, new_seed)

let save_seed is_crash parent seed =
  let seed_name = SeedPool.name_seed ~parent seed in
  if is_crash then ALlvm.save_ll !Config.crash_dir seed_name seed.llm
  else ALlvm.save_ll !Config.corpus_dir seed_name seed.llm

(* each mutant is mutated [Config.num_mutation] times *)
let mutate_seed llctx target_path llset (seed : SeedPool.seed_t) progress limit
    =
  assert (if not @@ seed.covers then seed.score > 0.0 else true);

  let rec traverse times (src : SeedPool.seed_t) progress =
    if times = 0 then (
      ALlvm.LLModuleSet.add llset src.llm ();
      None)
    else
      let dst = Mutator.run llctx src in
      match ALlvm.LLModuleSet.find_opt llset dst with
      | Some _ ->
          (* duplicate seed *)
          None
      | None -> (
          match check_mutant dst target_path src progress with
          | Interesting (is_crash, new_seed, new_progress) ->
              ALlvm.LLModuleSet.add llset new_seed.llm ();
              let seed_name = SeedPool.name_seed ~parent:seed new_seed in
              if is_crash then
                ALlvm.save_ll !Config.crash_dir seed_name new_seed.llm |> ignore
              else
                ALlvm.save_ll !Config.corpus_dir seed_name new_seed.llm
                |> ignore;
              Some (new_seed, new_progress)
          | Not_interesting (is_crash, new_seed) ->
              (if is_crash then
                 let seed_name = SeedPool.name_seed ~parent:seed new_seed in
                 ALlvm.save_ll !Config.crash_dir seed_name new_seed.llm
                 |> ignore);
              traverse (times - 1) { src with llm = dst } progress
          | Invalid -> traverse times src progress)
  in

  traverse limit seed progress

(** [run pool llctx cov_set get_count] pops seed from [pool]
    and mutate seed [Config.num_mutant] times.*)
let rec run pool llctx llset progress =
  let seed, pool_popped = SeedPool.pop pool in
  let target_path = CD.Path.parse !Config.cov_directed |> Option.get in
  let mutator = mutate_seed llctx target_path llset in

  pool
  |> SeedPool.iter (fun seed ->
         L.debug "prio: %d, seed: %a" seed.priority SeedPool.pp_seed seed);
  L.debug "fuzz-hash: %d\n" (ALlvm.string_of_llmodule seed.llm |> Hashtbl.hash);
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
  F.printf "\r%a@?" Progress.pp progress;

  List.iter (L.info "[new_seed] %a" SeedPool.pp_seed) new_seeds;
  let new_pool =
    pool_popped
    |> SeedPool.push_list new_seeds
    |> SeedPool.push
         {
           seed with
           priority =
             (match !Config.queue with
             | PQueue -> seed.priority + 1
             | FIFO -> 0);
         }
  in

  (* repeat until the time budget or seed pool exhausts *)
  let exhausted =
    !Config.time_budget > 0
    && AUtil.now () - !AUtil.start_time > !Config.time_budget
  in
  if exhausted then progress.cov_sofar else run new_pool llctx llset progress
