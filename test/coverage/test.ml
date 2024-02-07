module CD = Coverage.Domain
module CovAvg = CD.Make_coverage (CD.DistanceSetAvg)
module CovMin = CD.Make_coverage (CD.DistanceSetMin)

let _ =
  let target_path = CD.Path.parse "A:B:C:D" in
  let cov = CovAvg.read Sys.argv.(1) in
  let avg = CovAvg.score target_path cov in

  Format.printf "%a@." CovAvg.pp_metric avg;
  CovAvg.cover_target target_path cov |> Format.printf "%b@.";

  let cov = CovMin.read Sys.argv.(1) in
  let min = CovMin.score target_path cov in

  Format.printf "%a@." CovMin.pp_metric min;
  CovMin.cover_target target_path cov |> Format.printf "%b@.";

  ()
