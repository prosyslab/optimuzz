open Util
module L = Logger
module D = Domain
module Seed = Domain.NaiveSeed
module CD = Coverage.Domain
module Coverage = CD.SancovEdgeCoverage
module Opt = Oracle.Optimizer (Coverage)
include Queue

let can_optimize seedfile =
  match Opt.run ~passes:!Config.optimizer_passes seedfile with
  | Error Non_zero_exit | Error Hang ->
      L.info "%s cannot be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Error Cov_not_generated ->
      L.info "coverage of %s is not generated" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Ok coverage ->
      L.info "%s can be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      Some (seedfile, coverage)

let push seed pool =
  push seed pool;
  pool

let pop pool =
  let seed = pop pool in
  (seed, pool)

let make llctx selector =
  let seed_dir = !Config.seed_dir in
  let pool = create () in

  let seeds =
    Sys.readdir seed_dir
    |> Array.to_list
    |> List.map (Filename.concat seed_dir)
    |> List.filter_map can_optimize
    |> List.filter_map (fun (path, cov) ->
           let cov = selector cov in
           match ALlvm.read_ll llctx path with
           | Error _ -> None
           | Ok llm -> Some (path, llm, cov))
  in

  let cleaned_seeds =
    seeds
    |> List.filter (fun (_path, llm, _cov) -> Prep.check_llm_for_mutation llm)
    |> List.map (fun (_path, llm, _cov) -> llm)
  in

  let init_cov =
    List.fold_left
      (fun accu (_, _, cov) -> Coverage.union accu cov)
      Coverage.empty seeds
  in

  cleaned_seeds |> List.map Seed.make |> List.to_seq |> add_seq pool;

  (pool, init_cov)
