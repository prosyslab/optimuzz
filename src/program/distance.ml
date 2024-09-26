(** Distance Calculator
    1. Loads CFGs and CG which are resulted from an instrumenting compiler
    2. Construct a full graph from them
    3. Calculate scores based on distances to targets *)

module F = Format
module AG = Coverage.Aflgo

let print_calledge edge =
  let src = AG.G.E.src edge in
  let dst = AG.G.E.dst edge in
  match AG.G.E.label edge with
  | AG.Edge.Call -> F.printf "Call: %a -> %a@." AG.Node.pp src AG.Node.pp dst
  | AG.Edge.Flow -> ()

let main build_dir =
  Printexc.record_backtrace true;
  let issue_dir = Filename.dirname build_dir in
  let targets_file = Filename.concat issue_dir "targets" in
  let cfg_dir = Filename.concat build_dir "cfg" in
  let cfgs =
    Sys.readdir cfg_dir
    |> Array.to_list
    |> List.map (fun filename -> Filename.concat cfg_dir filename)
    |> List.filter (fun filename -> Filename.check_suffix filename ".dot")
    |> List.filter_map AG.ControlFlowGraph.of_dot_file
  in
  let calledges = AG.CallGraph.read (Filename.concat cfg_dir "callgraph.txt") in

  let fullgraph = AG.FullGraph.of_cfgs_and_calledges cfgs calledges in

  F.printf "%d CFGs are loaded@." (List.length cfgs);
  F.printf "%d vertices and %d edges are in the full graph@."
    (AG.G.nb_vertex fullgraph) (AG.G.nb_edges fullgraph);

  F.printf "Call edges@.";
  fullgraph |> AG.G.iter_edges_e print_calledge;
  F.printf "Targets@.";
  let targets =
    Coverage.Domain.parse_targets targets_file
    |> List.map (fun (filename, lineno) ->
           AG.FullGraph.find_targets (filename, lineno) fullgraph)
    |> List.flatten
  in
  targets |> List.iter (fun target -> F.printf "Target: %a@." AG.Node.pp target);

  F.printf "[Distance Map]@.";
  let distmap = AG.DistanceTable.build_distmap fullgraph targets in
  distmap
  |> AG.DistanceTable.iter (fun node dist ->
         F.printf "%a: %f@." AG.Node.pp node dist);
  ()

let _ = main Sys.argv.(1)
