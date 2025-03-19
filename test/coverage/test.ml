module CD = Coverage.Domain

let print_score = function
  | None -> Printf.printf "None\n"
  | Some x -> Printf.printf "%f\n" x

let test_edge_coverage () =
  let cov = CD.EdgeCoverage.read Sys.argv.(1) in
  Format.printf "%d@." (CD.EdgeCoverage.cardinal cov);
  ()

let main () =
  Printexc.record_backtrace true;
  (* If the filename starts with "edge" test edge coverage *)
  if String.sub Sys.argv.(1) 0 4 = "edge" then test_edge_coverage ()

let _ = main ()
