module CD = Coverage.Domain

let print_score = function
  | None -> Printf.printf "None\n"
  | Some x -> Printf.printf "%f\n" x

let test_ast_coverage () =
  let target_path = CD.Path.parse "A:B:C:D" |> Option.get in
  let cov = CD.AstCoverage.read Sys.argv.(1) in
  let avg_dist = CD.AverageDistance.distance target_path cov in
  let min_dist = CD.MinDistance.distance target_path cov in

  Format.printf "%a@." CD.AverageDistance.pp avg_dist;
  Format.printf "%a@." CD.MinDistance.pp min_dist;
  CD.AstCoverage.cover_target target_path cov |> Printf.printf "%b\n";
  ()

let test_edge_coverage () =
  let cov = CD.EdgeCoverage.read Sys.argv.(1) in
  Format.printf "%d@." (CD.EdgeCoverage.cardinal cov);
  ()

let main () =
  Printexc.record_backtrace true;
  (* If the filename starts with "edge" test edge coverage *)
  if String.sub Sys.argv.(1) 0 4 = "edge" then test_edge_coverage ()
  else test_ast_coverage ()

let _ = main ()
