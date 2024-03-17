module CD = Coverage.Domain

let print_score = function
  | CD.Infinity -> Printf.printf "None\n"
  | CD.Real x -> Printf.printf "%f\n" x

let _ =
  let target_path = CD.Path.parse "A:B:C:D" |> Option.get in
  let cov = CD.Cov.read Sys.argv.(1) in
  Coverage.Avg_dist.score target_path cov |> print_score;
  Coverage.Min_dist.score target_path cov |> print_score;
  CD.Cov.cover_target target_path cov |> Printf.printf "%b\n";

  ()
