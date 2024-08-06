open Util
module L = Logger
module D = Domain
module CD = Coverage.Domain
module Coverage = CD.EdgeCoverage
module Progress = CD.Progress (Coverage)
module Opt = Oracle.Optimizer (Coverage)
module Seed = Domain.NaiveSeed

let can_optimize file =
  match Opt.run ~passes:!Config.optimizer_passes file with
  | Error Non_zero_exit | Error Hang ->
      L.info "%s cannot be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      None
  | Error Cov_not_generated ->
      L.info "coverage of %s is not generated" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      None
  | Ok coverage ->
      L.info "%s can be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      Some (file, coverage)

let collect_cleaned_seeds llctx seed_dir =
  assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

  let seed_files = Sys.readdir seed_dir |> Array.to_list in

  let optimizable_seeds =
    seed_files
    |> List.map (Filename.concat seed_dir)
    |> List.filter_map can_optimize
    |> List.filter_map (fun (path, cov) ->
           match ALlvm.read_ll llctx path with
           | Error _ -> None
           | Ok llm -> Some (path, llm, cov))
  in
  if optimizable_seeds = [] then (
    L.info "No optimizable seeds found.";
    exit 1);

  let cleaned_seeds =
    optimizable_seeds
    |> List.filter (fun (_path, llm, _cov) -> Prep.check_llm_for_mutation llm)
  in

  (* cleaned_seeds can be cached since the collection is independent of target_path *)
  if cleaned_seeds = [] then (
    L.info "No cleaned seeds found.";
    exit 1);

  let initial_cov =
    List.fold_left
      (fun accu (_, _, cov) -> Coverage.union accu cov)
      Coverage.empty cleaned_seeds
  in

  (cleaned_seeds |> List.map (fun (path, llm, _cov) -> (path, llm)), initial_cov)

type elt = Seed.t
type t = elt Queue.t

let make llctx =
  let seed_dir = !Config.seed_dir in

  let pool = Queue.create () in

  let seeds, cov = collect_cleaned_seeds llctx seed_dir in

  seeds
  |> List.map (fun (_path, llm) -> Seed.make llm)
  |> List.to_seq
  |> Queue.add_seq pool;

  (pool, cov)

let empty : elt Queue.t = Queue.create ()

let push seed pool =
  Queue.push seed pool;
  pool

let register = push
let pop pool = (Queue.pop pool, pool)
let length = Queue.length
let iter = Queue.iter
