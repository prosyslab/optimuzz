module CD = Coverage.Domain

let print_score = function
  | None -> Printf.printf "None\n"
  | Some x -> Printf.printf "%f\n" x

let _ =
  let target_path = CD.Path.parse "A:B:C:D" in
  let cov = CD.Coverage.read Sys.argv.(1) in
  CD.Coverage.avg_score target_path cov |> print_score;
  CD.Coverage.min_score target_path cov |> print_score;
  CD.Coverage.cover_target target_path cov |> Printf.printf "%b\n";

  ()
