module F = Format
module G = Coverage.G
module CFG = Coverage.ControlFlowGraph
module CG = Coverage.CallGraph
module FG = Coverage.FullGraph
module Node = Coverage.Node
module DT = Coverage.DistanceTable
module A2N = Coverage.AddrToNode

let main dist_kind targets_file cfg_dir =
  assert (Sys.file_exists targets_file);
  assert (Sys.file_exists cfg_dir);
  assert (Sys.is_directory targets_file |> not);
  assert (Sys.is_directory cfg_dir);

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
    if dist_kind = "aflgo" then
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
  |> A2N.iter (fun addr node -> Format.eprintf "%x -> %a@." addr Node.pp node);

  Format.printf "[Distance Map]@.";
  distmap
  |> DT.iter (fun node dists ->
         F.printf "%a: %a@." Node.pp node F.pp_print_float dists)

let _ = main Sys.argv.(1) Sys.argv.(2) Sys.argv.(3)
