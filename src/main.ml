open Util
module F = Format
module L = Logger
module Progress = Coverage.Progress (Coverage.EdgeCoverage)
module G = Coverage.G
module CFG = Coverage.ControlFlowGraph
module CG = Coverage.CallGraph
module FG = Coverage.FullGraph
module Node = Coverage.Node
module Edge = Coverage.Edge
module A2N = Coverage.AddrToNode
module DT = Coverage.DistanceTable

let llctx = ALlvm.create_context ()

let initialize () =
  Printexc.record_backtrace true;
  ALlvm.set_opaque_pointers llctx true;
  Config.initialize llctx ();
  Random.self_init ()

let main targets_file cfg_dir =
  assert (Sys.file_exists targets_file);
  assert (Sys.file_exists cfg_dir);
  assert (Sys.is_directory targets_file |> not);
  assert (Sys.is_directory cfg_dir);

  let open Oracle in
  F.printf "[Input Targets]@.";
  let targets = Coverage.parse_targets targets_file in
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

  let calledges = CG.read (Filename.concat cfg_dir "callgraph.txt") in
  let fullgraph = FG.of_cfgs_and_calledges cfgs calledges in
  let target_nodes =
    targets
    |> List.map (fun (filename, lineno) ->
           FG.find_targets (Filename.basename filename, lineno) fullgraph)
    |> List.flatten
  in

  let aflgo_cg = CG.to_function_call_graph calledges in

  F.printf "[Target Nodes]@.";
  target_nodes |> List.iter (fun node -> F.printf "%a@." Node.pp node);

  if target_nodes = [] then (
    F.printf "no target nodes found@.";
    exit 0);

  let distmap =
    if !Config.score = Config.FuzzingMode.Aflgo then
      DT.build_distmap_aflgo cfgs aflgo_cg calledges target_nodes
    else DT.build_distmap fullgraph target_nodes
  in
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

  let seed_pool, init_cov = Seedpool.make llctx addr_to_node distmap in
  let sp_size = Seedpool.length seed_pool in

  F.printf "[Seeds] %d are loaded@." sp_size;
  if sp_size = 0 then exit 0;

  let llset = ALlvm.LLModuleSet.create sp_size in
  seed_pool
  |> Seedpool.iter (fun seed ->
         let filename = Seedpool.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (Seedpool.Seed.llmodule seed)
         |> ignore);

  if !Config.dry_run then exit 0;

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> Seedpool.iter (fun _ -> progress := Progress.inc_gen !progress);
  L.debug "initial progress: %a" Progress.pp !progress;

  let _coverage =
    Fuzzer.run seed_pool addr_to_node distmap llctx llset !progress
  in
  L.info "fuzzing campaign ends@."

let _ =
  initialize ();
  let targets_file = !Config.target_blocks_file in
  let cfg_dir = !Config.cfg_dir in
  main targets_file cfg_dir
