(** Distance Calculator
    1. Loads CFGs and CG which are resulted from an instrumenting compiler
    2. Construct a full graph from them
    3. Calculate scores based on distances to targets *)

module F = Format
module AG = Coverage.Aflgo

let main cfg_dir =
  Printexc.record_backtrace true;
  let cfgs =
    Sys.readdir cfg_dir
    |> Array.to_list
    |> List.map (fun filename -> Filename.concat cfg_dir filename)
    |> List.filter (fun filename -> Filename.check_suffix filename ".dot")
    |> List.filter_map AG.ControlFlowGraph.of_dot_file
  in
  let calledges = AG.CallGraph.read (Filename.concat cfg_dir "callgraph.txt") in
  let fullgraph = AG.FullGraph.of_cfgs_and_calledges cfgs calledges in

  F.eprintf "%d CFGs are loaded@." (List.length cfgs);
  F.eprintf "%d vertices and %d edges are in the full graph@."
    (AG.G.nb_vertex fullgraph) (AG.G.nb_vertex fullgraph);

  ()

let _ = main Sys.argv.(1)
