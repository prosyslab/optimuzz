module F = Format
module G = Coverage.Aflgo.G
module CD = Coverage.Domain
module CFG = Coverage.Aflgo.ControlFlowGraph
module CG = Coverage.Aflgo.CallGraph
module FG = Coverage.Aflgo.FullGraph
module Node = Coverage.Aflgo.Node
module DT = Coverage.Aflgo.DistanceTable
module A2N = Coverage.Aflgo.AddrToNode

let main targets_file cfg_dir =
  assert (Sys.file_exists targets_file);
  assert (Sys.file_exists cfg_dir);
  assert (Sys.is_directory targets_file |> not);
  assert (Sys.is_directory cfg_dir);

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

  let calledges = CG.read (Filename.concat cfg_dir "callgraph.txt") in
  let fullgraph = FG.of_cfgs_and_calledges cfgs calledges in
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
  |> A2N.iter (fun addr node -> F.printf "%x -> %a@." addr Node.pp node);

  Format.printf "[Distance Map]@.";
  distmap
  |> DT.iter (fun node dists ->
         F.printf "%a: %a@." Node.pp node F.pp_print_float dists)

let _ = main Sys.argv.(1) Sys.argv.(2)
