open Util
module F = Format
module L = Logger
module SP = Seedcorpus.Seedpool
module SD = Seedcorpus.Domain
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  Printexc.record_backtrace true;
  ALlvm.set_opaque_pointers llctx true;
  Config.initialize llctx ();
  Random.self_init ()

let llfuzz_ast_distanced_based (module SP : Seedcorpus.Ast_distance_based.POOL)
    target_path =
  let open Oracle in
  let llset = ALlvm.LLModuleSet.create 4096 in

  let module FZ = Fuzz.Ast_distance_based.Make (SP) in
  let module Coverage = CD.AstCoverage in
  let module Progress = CD.Progress (Coverage) in
  (* fuzzing *)
  let seed_pool = SP.make llctx target_path in
  F.printf "#initial seeds: %d@." (SP.length seed_pool);
  L.info "initial seeds: %d" (SP.length seed_pool);

  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  if SP.length seed_pool = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  seed_pool
  |> SP.iter (fun (seed : SP.Seed.t) ->
         ALlvm.LLModuleSet.add llset (SP.Seed.llmodule seed) ());

  if !Config.dry_run then exit 0;

  AUtil.start_time := AUtil.now ();
  L.info "fuzzing campaign starts@.";
  let coverage = FZ.run target_path seed_pool llctx llset Progress.empty in
  let end_time = AUtil.now () in
  L.info "fuzzing campaign ends@.";
  L.info "total coverage: %d lines" (Coverage.cardinal coverage);
  L.info "time spent: %ds" (end_time - !AUtil.start_time);

  F.printf "\ntotal coverage: %d lines@." (Coverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let pp_print_hex_int ppf n = F.fprintf ppf "0x%x" n

(** takes
    1. the filepath [targets_file] which contains a list of (filename:lineno) and
    2. a filepath [cfg_file] which contains the control flow graph of the program
*)
let llfuzz_cfg_slicing_based_directed targets_file cfg_file =
  assert (Sys.file_exists targets_file);
  assert (Sys.file_exists cfg_file);

  (* collect CFG information *)
  let open Oracle in
  let module SP = Seedcorpus.Sliced_cfg_edge_cov_based in
  let module FZ = Fuzz.Sliced_cfg_edge_cov_based in
  let module Progress = CD.Progress (CD.EdgeCoverage) in
  let targets =
    AUtil.read_lines targets_file
    |> List.map (fun line ->
           let chunks = String.split_on_char ':' line in
           (List.nth chunks 0, int_of_string (List.nth chunks 1)))
  in

  F.printf "[Input Targets]@.";
  targets
  |> List.iter (fun (filename, lineno) ->
         F.printf "target: %s:%d@." (Filename.basename filename) lineno);

  let cfg = CD.Cfg.read cfg_file in
  let target_nodes =
    targets
    |> List.fold_left
         (fun accu (filename, lineno) ->
           let targets =
             CD.Cfg.find_targets (Filename.basename filename, lineno) cfg
           in
           List.fold_left (fun accu v -> v :: accu) accu targets)
         []
  in

  F.printf "[Target Nodes]@.";
  target_nodes |> List.iter (fun node -> F.printf "%a@." CD.Cfg.V.pp node);

  let module FloatSet = Set.Make (Float) in
  let arith_avg fset =
    let sum = FloatSet.fold (fun x accu -> accu +. x) fset 0.0 in
    sum /. Float.of_int (FloatSet.cardinal fset)
  in
  let harmonic_avg fset =
    let sum = FloatSet.fold (fun x accu -> accu +. (1.0 /. x)) fset 0.0 in
    Float.of_int (FloatSet.cardinal fset) /. sum
  in

  let distmap : CD.distmap =
    target_nodes
    |> List.map (fun target -> CD.Cfg.compute_distances cfg target)
    (* |> List.map (fun dmap ->
           dmap
           |> CD.Cfg.NodeMap.iter (fun node dist ->
                  F.printf "%a: %f@." CD.Cfg.V.pp node dist);
           dmap) *)
    |> List.map (fun distmap ->
           CD.Cfg.NodeMap.map (fun d -> FloatSet.singleton d) distmap)
    |> List.fold_left
         (CD.Cfg.NodeMap.union (fun _k d1 d2 ->
              FloatSet.union d1 d2 |> Option.some))
         CD.Cfg.NodeMap.empty
    |> CD.Cfg.NodeMap.map
         harmonic_avg (* block-level distance in a CFG uses harmonic mean *)
  in

  let node_tbl =
    CD.Cfg.G.fold_vertex (fun v accu -> (v.address, v) :: accu) cfg []
    |> List.to_seq
    |> CD.Cfg.NodeTable.of_seq
  in

  (* print node_tbl and distmap *)
  Format.printf "[Node Table]@.";
  node_tbl
  |> CD.Cfg.NodeTable.iter (fun addr node ->
         F.printf "%a: %a@." pp_print_hex_int addr CD.Cfg.V.pp node);

  Format.printf "[Distance Map]@.";
  distmap
  |> CD.Cfg.NodeMap.iter (fun node dists ->
         F.printf "%a: %a@." CD.Cfg.V.pp node F.pp_print_float dists);

  if !Config.dry_run then exit 0;
  let seed_pool, init_cov = SP.make llctx node_tbl distmap in
  let sp_size = SP.length seed_pool in

  if sp_size = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  let llset = ALlvm.LLModuleSet.create sp_size in
  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name (SP.Seed.llmodule seed) in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> SP.iter (fun _ -> progress := Progress.inc_gen !progress);

  let _coverage = FZ.run seed_pool node_tbl distmap llctx llset in
  L.info "fuzzing campaign ends@."

let llfuzz_edge_cov_based_greybox () =
  let open Oracle in
  let module SP = Seedcorpus.Edge_cov_based in
  let module FZ = Fuzz.Edge_cov_based in
  let module Progress = CD.Progress (CD.EdgeCoverage) in
  let seed_pool, init_cov = SP.make llctx in

  let sp_size = SP.length seed_pool in
  F.printf "#initial seeds: %d@." sp_size;
  L.info "initial seeds: %d" sp_size;

  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  if sp_size = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  if !Config.dry_run then exit 0;

  let llset = ALlvm.LLModuleSet.create sp_size in

  seed_pool
  |> SP.iter (fun (seed : SP.Seed.t) ->
         ALlvm.LLModuleSet.add llset (SP.Seed.llmodule seed) ());

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> SP.iter (fun _ -> progress := Progress.inc_gen !progress);

  let _coverage = FZ.run seed_pool llctx llset !progress in
  L.info "fuzzing campaign ends@."

let _ =
  initialize ();
  match !Config.mode with
  | Config.Mode.Ast_distance_based s -> (
      F.printf "ast-distance based directed mode@.";
      let target_path = CD.Path.parse s |> Option.get in
      let module SA = Seedcorpus.Ast_distance_based in
      match (!Config.metric, !Config.queue) with
      | Config.Min_metric, Config.Fifo_queue ->
          let module MinFifoPool =
            SA.FifoSeedPool (SD.DistancedSeed (CD.MinDistance)) in
          llfuzz_ast_distanced_based (module MinFifoPool) target_path
      | Config.Min_metric, Config.Priority_queue ->
          let module MinPriorityPool =
            SA.PrioritySeedPool (SD.PriorityDistancedSeed (CD.MinDistance)) in
          llfuzz_ast_distanced_based (module MinPriorityPool) target_path
      | Config.Avg_metric, Config.Fifo_queue ->
          let module AvgFifoPool =
            SA.FifoSeedPool (SD.DistancedSeed (CD.AverageDistance)) in
          llfuzz_ast_distanced_based (module AvgFifoPool) target_path
      | Config.Avg_metric, Config.Priority_queue ->
          let module AvgPriorityPool =
            SA.PrioritySeedPool (SD.PriorityDistancedSeed (CD.AverageDistance)) in
          llfuzz_ast_distanced_based (module AvgPriorityPool) target_path)
  | Directed (targets_file, cfg_file) ->
      F.printf "CFG slicing based directed mode@.";
      llfuzz_cfg_slicing_based_directed targets_file cfg_file
  | Greybox ->
      F.printf "greybox mode@.";
      llfuzz_edge_cov_based_greybox ()
  | Blackbox ->
      F.printf "blackbox mode@.";
      failwith "Not implemented"
