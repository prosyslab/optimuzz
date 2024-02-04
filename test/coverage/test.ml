module CD = Coverage.Domain

let _ =
  let target_path = CD.Path.parse "A:B:C:D" in
  let cov = CD.CoverageAvg.read Sys.argv.(1) in
  let avg = CD.CoverageAvg.score target_path cov in

  let cov = CD.CoverageMin.read Sys.argv.(1) in
  let min = CD.CoverageMin.score target_path cov in

  Printf.printf "%f\n" (Option.get avg);
  Printf.printf "%d\n" (Option.get min);

  CD.CoverageMin.cover_target target_path cov |> Printf.printf "%b\n";

  ()
