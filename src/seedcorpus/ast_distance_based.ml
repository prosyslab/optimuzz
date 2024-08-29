open Util
module D = Domain
module L = Logger
module CD = Coverage.Domain
module Coverage = CD.AstCoverage
module Opt = Oracle.Optimizer

let can_optimize file =
  match Opt.run ~passes:!Config.optimizer_passes file with
  | Error Non_zero_exit | Error Hang ->
      L.info "%s cannot be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      false
  | Ok _ | Error File_not_found ->
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
           match ALlvm.read_ll llctx path with
           | Error _ -> None
           | Ok llm -> Some (path, llm))
  in
  if optimizable_seeds = [] then (
    L.info "No optimizable seeds found.";
    exit 1);

  let cleaned_seeds =
    optimizable_seeds
    |> List.filter (fun (_path, llm) -> Prep.check_llm_for_mutation llm)
    (* |> List.filter_map (fun (path, llm) ->
           ALlvm.clean_module_data llm;
           Prep.clean_llm llctx true llm |> Option.map (fun llm -> (path, llm))) *)
  in

  (* cleaned_seeds can be cached since the collection is independent of target_path *)
  if cleaned_seeds = [] then (
    L.info "No cleaned seeds found.";
    exit 1);

  cleaned_seeds

module type DISTANCED_SEED = sig
  module Distance : CD.Distance

  type t

  include D.SEED_PRINTER with type t := t
  include D.SEED_MEASURE with type t := t with module Distance := Distance

  val make : Llvm.llmodule -> CD.Path.t -> Coverage.t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
end

module type DISTANCED_PRIORITY_SEED = sig
  module Distance : CD.Distance

  type t

  include D.SEED_PRINTER with type t := t
  include D.SEED_MEASURE with type t := t with module Distance := Distance

  val make : Llvm.llmodule -> CD.Path.t -> Coverage.t -> t
  val priority : t -> int
  val inc_priority : t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
end

module type POOL = sig
  module Seed : DISTANCED_SEED
  include D.QUEUE with type elt = Seed.t

  val make : Llvm.llcontext -> CD.Path.t -> t
end

module Make_priority_queue (S : DISTANCED_PRIORITY_SEED) :
  D.QUEUE with type elt = S.t = struct
  type elt = S.t
  type t = elt AUtil.PrioQueue.queue

  let empty = AUtil.PrioQueue.empty
  let register seed pool = AUtil.PrioQueue.insert pool (S.priority seed) seed

  let push seed pool =
    let seed = S.inc_priority seed in
    AUtil.PrioQueue.insert pool (S.priority seed) seed

  let pop = AUtil.PrioQueue.extract
  let length = AUtil.PrioQueue.length
  let iter = AUtil.PrioQueue.iter
end

module Make_fifo_queue (S : DISTANCED_SEED) : D.QUEUE with type elt = S.t =
struct
  type elt = S.t
  type t = elt Queue.t

  let empty = Queue.create ()

  let push seed pool =
    Queue.push seed pool;
    pool

  let register = push
  let pop pool = (Queue.pop pool, pool)
  let length = Queue.length
  let iter = Queue.iter
end

module FifoSeedPool (Seed : DISTANCED_SEED) : POOL = struct
  module Seed = Seed
  include Make_fifo_queue (Seed)
  module Opt = Oracle.Optimizer

  let run_opt llm =
    let h = ALlvm.hash_llm llm in
    let filename = Format.sprintf "id:%010d.ll" h in
    let filename = ALlvm.save_ll !Config.out_dir filename llm in
    let res = Opt.run ~passes:!Config.optimizer_passes filename in
    AUtil.clean filename;
    match res with
    | Error Opt.File_not_found ->
        Format.eprintf "Coverage not generated: %s@." filename;
        None
    | Error _ -> None
    | Ok lines -> Some (h, lines)

  let construct_seedpool ?(max_size : int = 100) target_path llmodules =
    let open AUtil in
    let seeds =
      llmodules
      |> List.filter_map (fun llm ->
             let* _, lines = run_opt llm in
             let cov = Coverage.of_lines lines in
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
      let pool_closest =
        pool_noncovers
        |> List.sort_uniq (fun a b ->
               compare
                 (ALlvm.hash_llm (Seed.llmodule a))
                 (ALlvm.hash_llm (Seed.llmodule b)))
        |> List.sort (fun a b -> compare (Seed.score a) (Seed.score b))
        |> take max_size
      in
      pool_closest |> List.fold_left (fun pool seed -> push seed pool) empty)
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

    collect_cleaned_seeds llctx seed_dir
    |> List.map (fun (path, llm) ->
           L.info "trace: %s -> %010d@." path (ALlvm.hash_llm llm);
           llm)
    |> construct_seedpool target_path
end

module PrioritySeedPool (Seed : DISTANCED_PRIORITY_SEED) : POOL = struct
  include Make_priority_queue (Seed)
  module Seed = Seed
  module Opt = Oracle.Optimizer

  let run_opt llm =
    let h = ALlvm.hash_llm llm in
    let filename = Format.sprintf "id:%010d.ll" h in
    let filename = ALlvm.save_ll !Config.out_dir filename llm in
    let res = Opt.run ~passes:!Config.optimizer_passes filename in
    AUtil.clean filename;
    match res with
    | Error Opt.File_not_found ->
        Format.eprintf "Coverage not generated: %s@." filename;
        None
    | Error _ -> None
    | Ok lines -> Some (h, lines)

  let get_prio covers (score : Seed.Distance.t) =
    if covers then 0 else score |> Seed.Distance.to_priority

  let construct_seedpool ?(max_size : int = 100) target_path llmodules =
    let open AUtil in
    let seeds =
      llmodules
      |> List.filter_map (fun llm ->
             let* _, lines = run_opt llm in
             let cov = Coverage.of_lines lines in
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

    collect_cleaned_seeds llctx seed_dir
    |> List.map (fun (path, llm) ->
           L.info "%s -> %010d@." path (ALlvm.hash_llm llm);
           llm)
    |> construct_seedpool target_path

  (** make seedpool from Config.seed_dir. this queue contains llmodule, covered, distance *)
  let make llctx target_path =
    let seed_dir = !Config.seed_dir in
    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

    match !Config.seedpool_option with
    | Config.Fresh -> make_fresh llctx seed_dir target_path
    | _ -> failwith "Temporarily disabled seedpool construction"
end
