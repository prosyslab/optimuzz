open Util
module L = Logger
module D = Domain
module Seed = Domain.CfgSeed
module CD = Coverage.Domain
module Coverage = CD.EdgeCoverage
module Trace = CD.BlockTrace
module Opt = Oracle.Optimizer (Trace)
include Queue

let can_optimize seedfile =
  match Opt.run ~passes:!Config.optimizer_passes seedfile with
  | Error Non_zero_exit | Error Hang ->
      L.debug "%s cannot be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Error Cov_not_generated ->
      L.debug "coverage of %s is not generated" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Ok coverage ->
      L.debug "%s can be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      Some (seedfile, coverage)

let push (seed : Seed.t) pool =
  let llm = seed.llm in
  let seed_name = Seed.name seed in
  ALlvm.save_ll !Config.corpus_dir seed_name llm |> ignore;
  push seed pool;
  pool

let pop pool =
  let seed = pop pool in
  (seed, pool)

let evaluate_seeds_and_construct_seedpool ?(max_size : int = 100) seeds node_tbl
    distmap =
  let open AUtil in
  let pool = create () in
  let pool_covers, pool_noncovers =
    List.fold_left
      (fun (pool_covers, pool_noncovers) (_, llm, trace) ->
        let seed = Seed.make llm trace node_tbl distmap in
        if Seed.covers seed then (seed :: pool_covers, pool_noncovers)
        else (pool_covers, seed :: pool_noncovers))
      ([], []) seeds
  in
  if pool_covers = [] then (
    L.info "No covering seeds found. Using closest seeds.";
    let pool_closest =
      pool_noncovers
      |> List.sort_uniq (fun a b ->
             compare
               (ALlvm.hash_llm (Seed.llmodule a))
               (ALlvm.hash_llm (Seed.llmodule b)))
      |> List.sort (fun a b -> compare (Seed.score a) (Seed.score b))
      |> take max_size
    in
    let init_cov =
      List.fold_left
        (fun accu seed -> Coverage.union accu (Seed.edge_cov seed))
        Coverage.empty pool_closest
    in
    pool_closest |> List.to_seq |> add_seq pool;
    (pool, init_cov))
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
    let init_cov =
      List.fold_left
        (fun accu seed -> Coverage.union accu (Seed.edge_cov seed))
        Coverage.empty pool_covers
    in
    pool_covers |> List.to_seq |> add_seq pool;
    (pool, init_cov))

let make llctx node_tbl (distmap : CD.distmap) =
  let open AUtil in
  let seed_dir = !Config.seed_dir in

  let filter_seed seed =
    let* path, cov = can_optimize seed in
    match ALlvm.read_ll llctx path with
    | Error _ -> None
    | Ok llm -> Some (path, llm, cov)
  in

  let seeds =
    Sys.readdir seed_dir
    |> (fun x ->
         L.info "%d seeds found" (Array.length x);
         x)
    |> Array.to_list
    |> List.map (Filename.concat seed_dir)
    |> List.filter_map filter_seed
    |> List.filter (fun (_path, llm, _cov) -> Prep.check_llm_for_mutation llm)
  in

  evaluate_seeds_and_construct_seedpool seeds node_tbl distmap
