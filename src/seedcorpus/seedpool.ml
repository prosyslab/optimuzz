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

let parse_seed_filename filename =
  let filename = Filename.chop_extension filename in
  (* covers:true -> true *)
  let parse_covers s =
    let colon = String.index s ':' in
    String.sub s (colon + 1) (String.length s - colon - 1)
  in

  (* score:4.500 -> 4.500 *)
  let parse_score s =
    let colon = String.index s ':' in
    String.sub s (colon + 1) (String.length s - colon - 1)
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
      Format.asprintf "Can't parse the filename: %s@." filename |> Result.error

module type SEED = sig
  module Distance : CD.Distance

  type t

  val make : Llvm.llmodule -> CD.Path.t -> CD.Coverage.t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
  val covers : t -> bool
  val score : t -> Distance.t
  val name : ?parent:int -> t -> string
  val pp : Format.formatter -> t -> unit
  val closer : t -> t -> bool
end

module type PRIORITY_SEED = sig
  module Distance : CD.Distance

  type t

  val make : Llvm.llmodule -> CD.Path.t -> CD.Coverage.t -> t
  val priority : t -> int
  val inc_priority : t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
  val covers : t -> bool
  val score : t -> Distance.t
  val name : ?parent:int -> t -> string
  val pp : Format.formatter -> t -> unit
  val closer : t -> t -> bool
end

module type QUEUE = sig
  type elt
  type t

  val empty : t

  val register : elt -> t -> t
  (** push a seed to the queue for the first time *)

  val push : elt -> t -> t
  (** push a seed to the queue -- not the first time *)

  val push_if_closer : elt -> elt -> t -> t
  val pop : t -> elt * t
  val length : t -> int
  val iter : (elt -> unit) -> t -> unit
end

module Make_priority_queue (S : PRIORITY_SEED) : QUEUE with type elt = S.t =
struct
  type elt = S.t
  type t = elt AUtil.PrioQueue.queue

  let empty = AUtil.PrioQueue.empty
  let register seed pool = AUtil.PrioQueue.insert pool (S.priority seed) seed

  let push seed pool =
    let seed = S.inc_priority seed in
    AUtil.PrioQueue.insert pool (S.priority seed) seed

  let push_if_closer old_seed new_seed pool =
    if S.closer old_seed new_seed then push new_seed pool else pool

  let pop = AUtil.PrioQueue.extract
  let length = AUtil.PrioQueue.length
  let iter = AUtil.PrioQueue.iter
end

module Make_fifo_queue (S : SEED) : QUEUE with type elt = S.t = struct
  type elt = S.t
  type t = elt Queue.t

  let empty = Queue.create ()

  let push seed pool =
    Queue.push seed pool;
    pool

  let register = push

  let push_if_closer old_seed seed pool =
    if S.closer old_seed seed then push seed pool else pool

  let pop pool = (Queue.pop pool, pool)
  let length = Queue.length
  let iter = Queue.iter
end

module Seed (Distance : CD.Distance) = struct
  module Distance = Distance

  type t = { llm : Llvm.llmodule; score : Distance.t; covers : bool }

  let make llm target_path cov =
    let covers = CD.Coverage.cover_target target_path cov in
    let score = Distance.distance target_path cov in
    { llm; covers; score }

  let llmodule seed = seed.llm
  let covers seed = seed.covers
  let score seed = seed.score
  let overwrite seed llm = { seed with llm }

  let pp fmt seed =
    Format.fprintf fmt "hash: %10d, score: %a, covers: %b"
      (ALlvm.hash_llm seed.llm) Distance.pp seed.score seed.covers

  let name ?(parent : int option) seed =
    let hash = ALlvm.hash_llm seed.llm in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d,score:%a,covers:%b.ll"
          (AUtil.get_current_time ())
          hash Distance.pp seed.score seed.covers
    | Some parent_hash ->
        Format.asprintf "date:%s,id:%010d,src:%010d,score:%a,covers:%b.ll"
          (AUtil.get_current_time ())
          hash parent_hash Distance.pp seed.score seed.covers

  let closer old_seed new_seed =
    new_seed.covers || ((not old_seed.covers) && new_seed.score < old_seed.score)
end

module PrioritySeed (Dist : CD.Distance) = struct
  module Distance = Dist
  module Seed = Seed (Dist)

  type t = int * Seed.t

  let make llm target_path cov =
    let seed = Seed.make llm target_path cov in
    (Seed.score seed |> Seed.Distance.to_priority, seed)

  let priority seed = fst seed
  let inc_priority seed = (fst seed + 1, snd seed)
  let llmodule seed = snd seed |> Seed.llmodule
  let covers seed = Seed.covers (snd seed)
  let score (seed : t) = Seed.score (snd seed)
  let overwrite seed llm = (fst seed, Seed.overwrite (snd seed) llm)
  let pp fmt seed = Seed.pp fmt (snd seed)
  let name ?parent seed = Seed.name ?parent (snd seed)
  let closer old_seed new_seed = Seed.closer (snd old_seed) (snd new_seed)
end

module type SEED_POOL = sig
  module Seed : SEED
  include QUEUE with type elt = Seed.t

  val make : Llvm.llcontext -> CD.Path.t -> t
end

module FifoSeedPool (Seed : SEED) : SEED_POOL = struct
  module Seed = Seed
  include Make_fifo_queue (Seed)

  let construct_seedpool ?(max_size : int = 100) target_path llmodules =
    let open AUtil in
    let seeds =
      llmodules
      |> List.filter_map (fun llm ->
             let* _, cov = run_opt llm in
             Seed.make llm target_path cov |> Option.some)
    in
    let pool_covers, pool_noncovers =
      seeds
      |> List.fold_left
           (fun (pool_first, other_seeds) seed ->
             if Seed.covers seed then (seed :: pool_first, other_seeds)
             else (pool_first, seed :: other_seeds))
           ([], [])
    in

    if pool_covers = [] then (
      L.info "No covering seeds found. Using closest seeds.";
      (* pool_closest contains seeds which are closest to the target *)
      let _cnt, pool_closest =
        pool_noncovers
        |> List.sort_uniq (fun a b ->
               compare
                 (ALlvm.hash_llm (Seed.llmodule a))
                 (ALlvm.hash_llm (Seed.llmodule b)))
        |> List.sort (fun a b -> compare (Seed.score a) (Seed.score b))
        |> List.fold_left
             (fun (cnt, pool) seed ->
               if cnt >= max_size then (cnt, pool)
               else (cnt + 1, register seed pool))
             (0, empty)
      in
      pool_closest)
    else (
      (* if we have covering seeds, we use covering seeds only. *)
      L.info "Covering seeds found. Using them only.";
      let pool_covers =
        pool_covers
        |> List.sort_uniq (fun a b ->
               compare
                 (ALlvm.hash_llm (Seed.llmodule a))
                 (ALlvm.hash_llm (Seed.llmodule b)))
      in

      pool_covers |> List.fold_left (fun pool seed -> push seed pool) empty)

  let make llctx target_path =
    let seed_dir = !Config.seed_dir in
    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

    collect_cleaned_seeds llctx seed_dir |> construct_seedpool target_path
end

module PrioritySeedPool (Seed : PRIORITY_SEED) : SEED_POOL = struct
  include Make_priority_queue (Seed)
  module Seed = Seed

  let get_prio covers (score : Seed.Distance.t) =
    if covers then 0 else score |> Seed.Distance.to_priority

  (* let resume_seedpool llctx dir seedpool =
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

     push_list seeds seedpool *)

  let construct_seedpool ?(max_size : int = 100) target_path llmodules =
    let open AUtil in
    let seeds =
      llmodules
      |> List.filter_map (fun llm ->
             let* _, cov = run_opt llm in
             Seed.make llm target_path cov |> Option.some)
    in
    let pool_covers, pool_noncovers =
      seeds
      |> List.fold_left
           (fun (pool_first, other_seeds) seed ->
             if Seed.covers seed then (seed :: pool_first, other_seeds)
             else (pool_first, seed :: other_seeds))
           ([], [])
    in

    if pool_covers = [] then (
      L.info "No covering seeds found. Using closest seeds.";
      (* pool_closest contains seeds which are closest to the target *)
      let _cnt, pool_closest =
        pool_noncovers
        |> List.sort_uniq (fun a b ->
               compare
                 (ALlvm.hash_llm (Seed.llmodule a))
                 (ALlvm.hash_llm (Seed.llmodule b)))
        |> List.sort (fun a b -> compare (Seed.score a) (Seed.score b))
        |> List.fold_left
             (fun (cnt, pool) seed ->
               if cnt >= max_size then (cnt, pool)
               else (cnt + 1, register seed pool))
             (0, empty)
      in
      pool_closest)
    else (
      (* if we have covering seeds, we use covering seeds only. *)
      L.info "Covering seeds found. Using them only.";
      let pool_covers =
        pool_covers
        |> List.sort_uniq (fun a b ->
               compare
                 (ALlvm.hash_llm (Seed.llmodule a))
                 (ALlvm.hash_llm (Seed.llmodule b)))
      in

      pool_covers |> List.fold_left (fun pool seed -> register seed pool) empty)

  let make_fresh llctx seed_dir target_path =
    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

    collect_cleaned_seeds llctx seed_dir |> construct_seedpool target_path

  (* let make_skip_clean llctx seed_dir target_path =
     let seed_files = Sys.readdir seed_dir |> Array.to_list in
     seed_files
     |> List.map (Filename.concat seed_dir)
     |> List.map (ALlvm.read_ll llctx)
     |> List.filter_map Result.to_option
     |> construct_seedpool target_path *)

  (** make seedpool from Config.seed_dir. this queue contains llmodule, covered, distance *)
  let make llctx target_path =
    let seed_dir = !Config.seed_dir in
    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

    match !Config.seedpool_option with
    | Config.Fresh -> make_fresh llctx seed_dir target_path
    | _ -> failwith "Temporarily disabled seedpool construction"
  (* | Config.SkipClean -> make_skip_clean llctx seed_dir target_path *)
  (* | Config.Resume ->
      assert (
        Sys.file_exists !Config.crash_dir
        && Sys.is_directory !Config.crash_dir);
      AUtil.PrioQueue.empty
      |> resume_seedpool llctx !Config.crash_dir
      |> resume_seedpool llctx !Config.corpus_dir *)
end
