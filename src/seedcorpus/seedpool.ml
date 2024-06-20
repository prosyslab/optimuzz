open Util
module CD = Coverage.Domain
module L = Logger

let run_opt llm =
  let h = ALlvm.hash_llm llm in
  let filename = Format.sprintf "id:%010d.ll" h in
  let filename = ALlvm.save_ll !Config.out_dir filename llm in
  let res = Oracle.Optimizer.run ~passes:!Config.optimizer_passes filename in
  AUtil.clean filename;
  match res with
  | Error Oracle.Optimizer.Cov_not_generated ->
      Format.eprintf "Coverage not generated: %s@." filename;
      None
  | Error _ -> None
  | Ok cov -> Some (h, cov)

let can_optimize file =
  match Oracle.Optimizer.run ~passes:!Config.optimizer_passes file with
  | Error Non_zero_exit | Error Hang ->
      L.info "%s cannot be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      false
  | Ok _ | Error Cov_not_generated ->
      L.info "%s can be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      true

let collect_cleaned_seeds llctx seed_dir =
  assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

  let seed_files = Sys.readdir seed_dir |> Array.to_list in

  let optimizable_seeds =
    seed_files
    |> List.map (Filename.concat seed_dir)
    |> List.filter can_optimize
    |> List.filter_map (fun path ->
           ALlvm.read_ll llctx path |> Result.to_option)
  in
  if optimizable_seeds = [] then (
    L.info "No optimizable seeds found.";
    exit 1);

  let cleaned_seeds =
    optimizable_seeds
    |> List.filter Prep.check_llm_for_mutation
    |> List.filter_map (fun llm ->
           ALlvm.clean_module_data llm;
           Prep.clean_llm llctx true llm)
  in

  (* cleaned_seeds can be cached since the collection is independent of target_path *)
  if cleaned_seeds = [] then (
    L.info "No cleaned seeds found.";
    exit 1);

  cleaned_seeds

module type SeedPool = sig
  module Dist : CD.Distance

  type seed_t = {
    priority : int;
    llm : Llvm.llmodule;
    covers : bool;
    score : Dist.t;
  }

  type t

  val pp_seed : Format.formatter -> seed_t -> unit
  val name_seed : ?parent:seed_t -> seed_t -> string
  val make_seed : Llvm.llmodule -> CD.Path.t -> CD.Coverage.t -> seed_t
  val push : seed_t -> t -> t
  val pop : t -> seed_t * t
  val cardinal : t -> int
  val push_list : seed_t list -> t -> t
  val iter : (seed_t -> unit) -> t -> unit
  val make : Llvm.llcontext -> t
end

module Make (Distance : CD.Distance) : SeedPool = struct
  module Dist = Distance

  type seed_t = {
    priority : int;
    llm : Llvm.llmodule;
    covers : bool;
    score : Dist.t;
  }

  type t = seed_t AUtil.PrioQueue.queue

  let pp_seed fmt seed =
    Format.fprintf fmt "score: %a, covers: %b" Dist.pp seed.score seed.covers

  let name_seed ?(parent : seed_t option) (seed : seed_t) =
    let hash = ALlvm.string_of_llmodule seed.llm |> Hashtbl.hash in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d,score:%a,covers:%b.ll"
          (AUtil.get_current_time ())
          hash Dist.pp seed.score seed.covers
    | Some { llm = src; _ } ->
        Format.asprintf "date:%s,id:%010d,src:%010d,score:%a,covers:%b.ll"
          (AUtil.get_current_time ())
          hash
          (ALlvm.string_of_llmodule src |> Hashtbl.hash)
          Dist.pp seed.score seed.covers

  let get_prio covers (score : Dist.t) =
    match !Config.queue with
    | Priority_queue -> if covers then 0 else score |> Dist.to_priority
    | Fifo_queue -> 0 (* ignore score *)

  let push s pool = AUtil.PrioQueue.insert pool s.priority s
  let pop pool = AUtil.PrioQueue.extract pool
  let cardinal = AUtil.PrioQueue.length
  let push_list l (p : t) = List.fold_left (fun pool seed -> push seed pool) p l
  let iter = AUtil.PrioQueue.iter

  let make_seed llm target_path cov =
    let covers = CD.Coverage.cover_target target_path cov in
    let score = Dist.distance target_path cov in
    L.info "[Seed] Score: %a" Dist.pp score;
    { priority = get_prio covers score; llm; covers; score }

  let parse_seed_filename filename =
    let filename = Filename.chop_extension filename in
    (* covers:true -> true *)
    let parse_covers s =
      let colon = String.index s ':' in
      let s = String.sub s (colon + 1) (String.length s - colon - 1) in
      bool_of_string s
    in
    (* score:4.500 -> 4.500 *)
    let parse_score s =
      let colon = String.index s ':' in
      let s = String.sub s (colon + 1) (String.length s - colon - 1) in
      Dist.of_string s
    in
    match String.split_on_char ',' filename with
    | [ _date; _id; score; covers ] ->
        let covers = parse_covers covers in
        let score = parse_score score in
        Ok (covers, score)
    | [ _date; _id; _src; score; covers ] ->
        let covers = parse_covers covers in
        let score = parse_score score in
        Ok (covers, score)
    | lst ->
        List.iter (Format.eprintf "%s@.") lst;
        Format.asprintf "Can't parse the filename: %s@." filename
        |> Result.error

  let resume_seedpool llctx dir seedpool =
    let open AUtil in
    let seedfiles = Sys.readdir dir |> Array.to_list in
    let seeds =
      seedfiles
      |> filter_map_res (fun file ->
             let+ llm = ALlvm.read_ll llctx (Filename.concat dir file) in
             let+ covers, score = parse_seed_filename file in
             Ok { priority = get_prio covers score; llm; covers; score })
    in

    Format.eprintf "Resuming %d seeds@." (List.length seeds);

    push_list seeds seedpool

  let construct_seedpool ?(max_size : int = 100) target_path llmodules =
    let open AUtil in
    let seeds =
      llmodules
      |> List.filter_map (fun llm ->
             let* _, cov = run_opt llm in
             make_seed llm target_path cov |> Option.some)
    in
    let pool_covers, pool_noncovers =
      seeds
      |> List.fold_left
           (fun (pool_first, other_seeds) seed ->
             if seed.covers then (seed :: pool_first, other_seeds)
             else (pool_first, seed :: other_seeds))
           ([], [])
    in

    if pool_covers = [] then (
      L.info "No covering seeds found. Using closest seeds.";
      (* pool_closest contains seeds which are closest to the target *)
      let _cnt, pool_closest =
        pool_noncovers
        |> List.sort_uniq (fun a b ->
               compare (ALlvm.hash_llm a.llm) (ALlvm.hash_llm b.llm))
        |> List.sort (fun a b -> compare a.score b.score)
        |> List.fold_left
             (fun (cnt, pool) seed ->
               if cnt >= max_size then (cnt, pool) else (cnt + 1, push seed pool))
             (0, AUtil.PrioQueue.empty)
      in
      pool_closest)
    else (
      (* if we have covering seeds, we use covering seeds only. *)
      L.info "Covering seeds found. Using them only.";
      let pool_covers =
        pool_covers
        |> List.sort_uniq (fun a b ->
               compare (ALlvm.hash_llm a.llm) (ALlvm.hash_llm b.llm))
      in

      push_list pool_covers AUtil.PrioQueue.empty)

  let make_fresh llctx seed_dir target_path =
    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

    collect_cleaned_seeds llctx seed_dir |> construct_seedpool target_path

  let make_skip_clean llctx seed_dir target_path =
    let seed_files = Sys.readdir seed_dir |> Array.to_list in
    seed_files
    |> List.map (Filename.concat seed_dir)
    |> List.map (ALlvm.read_ll llctx)
    |> List.filter_map Result.to_option
    |> construct_seedpool target_path

  (** make seedpool from Config.seed_dir. this queue contains llmodule, covered, distance *)
  let make llctx =
    let seed_dir = !Config.seed_dir in
    let target_path = CD.Path.parse !Config.cov_directed |> Option.get in
    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

    match !Config.seedpool_option with
    | Config.Fresh -> make_fresh llctx seed_dir target_path
    | Config.SkipClean -> make_skip_clean llctx seed_dir target_path
    | Config.Resume ->
        assert (
          Sys.file_exists !Config.crash_dir
          && Sys.is_directory !Config.crash_dir);
        AUtil.PrioQueue.empty
        |> resume_seedpool llctx !Config.crash_dir
        |> resume_seedpool llctx !Config.corpus_dir
end
