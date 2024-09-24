open Util
module L = Logger
module D = Domain
module Seed = Domain.CfgSeed
module CD = Coverage.Domain
module Aflgo = Coverage.Aflgo
module Coverage = CD.EdgeCoverage
module Trace = CD.BlockTrace
module Opt = Oracle.Optimizer
include Queue

let can_optimize seedfile node_tbl distmap =
  match Opt.run ~passes:!Config.optimizer_passes seedfile with
  | Error Non_zero_exit | Error Hang ->
      L.debug "%s cannot be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Error File_not_found ->
      L.debug "coverage of %s is not generated" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Ok lines ->
      L.debug "%s can be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      let lines =
        lines
        |> List.filter (fun line ->
               let addr = int_of_string line in
               CD.sliced_cfg_node_of_addr node_tbl distmap addr
               |> Option.is_some)
      in
      Some (seedfile, lines)

let push (seed : Seed.t) pool =
  push seed pool;
  pool

let pop pool =
  let seed = pop pool in
  (seed, pool)

let save ?(parent : int option) (seed : Seed.t) =
  let llm = seed.llm in
  let seed_name =
    match parent with
    | None -> Seed.name seed
    | Some parent -> Seed.name ~parent seed
  in
  ALlvm.save_ll !Config.corpus_dir seed_name llm |> ignore

let evaluate_seeds_and_construct_seedpool ?(max_size : int = 100) seeds node_tbl
    distmap =
  let open AUtil in
  let pool = create () in
  let pool_covers, pool_noncovers =
    List.fold_left
      (fun (pool_covers, pool_noncovers) (_, llm, traces) ->
        let seed = Seed.make llm traces node_tbl distmap in
        L.debug "evaluate seed: \n%s\n" (ALlvm.string_of_llmodule llm);
        L.debug "score: %s" (string_of_float (Seed.score seed));
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

let make llctx node_tbl (distmap : float Aflgo.DistanceTable.t) =
  let open AUtil in
  let seed_dir = !Config.seed_dir in

  let add_dummy_params llm =
    let open ALlvm in
    let f_alls = fold_left_functions (fun accu f -> f :: accu) [] llm in
    let f_olds =
      List.fold_left
        (fun accu f_old ->
          let dummy_params = [| i32_type llctx; pointer_type llctx |] in
          let old_params = params f_old in
          let param_tys =
            Array.append (Array.map type_of old_params) dummy_params
          in
          let new_fnty = function_type (get_return_type f_old) param_tys in
          let name = value_name f_old in
          let f_new = clone_function_with_fnty f_old new_fnty in

          set_value_name name f_new;
          f_old :: accu)
        [] f_alls
    in
    f_olds
    |> List.rev
    |> List.iter (fun f_old ->
           replace_all_uses_with f_old (undef (pointer_type llctx));
           delete_function f_old);
    llm
  in

  let filter_seed seed =
    let* path, lines = can_optimize seed node_tbl distmap in
    match ALlvm.read_ll llctx path with
    | Error _ -> None
    | Ok llm ->
        let cov = lines |> Trace.of_lines in
        let llm = add_dummy_params llm in
        Some (path, llm, cov)
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

  let pool = evaluate_seeds_and_construct_seedpool seeds node_tbl distmap in

  pool
