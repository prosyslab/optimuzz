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
    1. [targets_file] which contains a list of (filename:lineno) and
    2-1. if not selective, a directory [cfg_dir] which contains CFGs of functions of the program and the call graph among them
    2-2. if selective, a directory [cfg_dir] which only contains the CFG of the target function
*)
let llfuzz_cfg_slicing_based_directed ?(selective = false) targets_file cfg_dir
    =
  assert (Sys.file_exists targets_file);
  assert (Sys.file_exists cfg_dir);
  assert (Sys.is_directory targets_file |> not);
  assert (Sys.is_directory cfg_dir);

  let open Oracle in
  let module SP = Seedcorpus.Sliced_cfg_edge_cov_based in
  let module FZ = Fuzz.Sliced_cfg_edge_cov_based in
  let module Progress = CD.Progress (CD.EdgeCoverage) in
  let module G = Coverage.Aflgo.G in
  let module CFG = Coverage.Aflgo.ControlFlowGraph in
  let module CG = Coverage.Aflgo.CallGraph in
  let module FG = Coverage.Aflgo.FullGraph in
  let module Node = Coverage.Aflgo.Node in
  let module Edge = Coverage.Aflgo.Edge in
  let module A2N = Coverage.Aflgo.AddrToNode in
  let module DT = Coverage.Aflgo.DistanceTable in
  F.printf "[Input Targets]@.";
  let targets = CD.parse_targets targets_file in
  targets
  |> List.iter (fun (filename, lineno) ->
         F.printf "target: %s:%d@." (Filename.basename filename) lineno);

  let cfgs =
    Sys.readdir cfg_dir
    |> Array.to_list
    |> List.map (fun filename -> Filename.concat cfg_dir filename)
    |> List.filter (fun filename -> Filename.check_suffix filename ".dot")
    |> List.filter_map CFG.of_dot_file
  in

  F.printf "%d CFGs are loaded@." (List.length cfgs);

  (* If selective, only use CFG of the target function *)
  (* Otherwise, construct the full graph of CFGs and the call graph *)
  let fullgraph =
    if not selective then
      let calledges = CG.read (Filename.concat cfg_dir "callgraph.txt") in
      let fg = FG.of_cfgs_and_calledges cfgs calledges in

      fg
    else
      (* choose the cfg which contains the target nodes *)
      let cfg =
        cfgs
        |> List.map CFG.graph
        |> List.find (fun cfg ->
               targets
               |> List.exists (fun (filename, lineno) ->
                      cfg
                      |> FG.find_targets (Filename.basename filename, lineno)
                      <> []))
      in

      cfg
  in
  let target_nodes =
    targets
    |> List.map (fun (filename, lineno) ->
           FG.find_targets (Filename.basename filename, lineno) fullgraph)
    |> List.flatten
  in

  F.printf "[Target Nodes]@.";
  target_nodes |> List.iter (fun node -> F.printf "%a@." Node.pp node);

  if target_nodes = [] then (
    F.printf "no target nodes found@.";
    exit 0);

  let distmap = DT.build_distmap fullgraph target_nodes in
  if DT.is_empty distmap then (
    F.printf "no distance map generated@.";
    exit 0);
  let addr_to_node =
    G.fold_vertex (fun v accu -> (v.addr, v) :: accu) fullgraph []
    |> A2N.of_assoc
  in

  (* print node_tbl and distmap *)
  Format.printf "[Node Table]@.";
  addr_to_node
  |> A2N.iter (fun addr node -> L.debug "%x -> %a" addr Node.pp node);

  Format.printf "[Distance Map]@.";
  distmap
  |> DT.iter (fun node dists ->
         F.printf "%a: %a@." Node.pp node F.pp_print_float dists;
         L.info "%a: %a" Node.pp node F.pp_print_float dists);

  let seed_pool, init_cov = SP.make llctx addr_to_node distmap in
  let sp_size = SP.length seed_pool in

  F.printf "[Seeds] %d are loaded@." sp_size;
  if sp_size = 0 then exit 0;

  let llset = ALlvm.LLModuleSet.create sp_size in
  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  if !Config.dry_run then exit 0;

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> SP.iter (fun _ -> progress := Progress.inc_gen !progress);
  L.debug "initial progress: %a" Progress.pp !progress;

  let _coverage = FZ.run seed_pool addr_to_node distmap llctx llset !progress in
  L.info "fuzzing campaign ends@."

let llfuzz_edge_cov_based_greybox () =
  let open Oracle in
  let module SP = Seedcorpus.Edge_cov_based in
  let module FZ = Fuzz.Edge_cov_based in
  let module Progress = CD.Progress (CD.PCGuardEdgeCoverage) in
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
  | Config.Mode.Ast_distance_based (metric, path) -> (
      F.printf "ast-distance based directed mode@.";
      let target_path = CD.Path.parse path |> Option.get in
      let module SA = Seedcorpus.Ast_distance_based in
      match (metric, !Config.queue) with
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
  | Directed (selective, targets_file, cfg_file) ->
      F.printf "CFG slicing based directed mode@.";
      F.printf "selective: %b@." selective;
      llfuzz_cfg_slicing_based_directed ~selective targets_file cfg_file
  | Greybox ->
      F.printf "greybox mode@.";
      llfuzz_edge_cov_based_greybox ()
  | Blackbox ->
      F.printf "blackbox mode@.";
      failwith "Not implemented"
