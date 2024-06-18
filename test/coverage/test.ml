module CD = Coverage.Domain

let print_score = function
  | None -> Printf.printf "None\n"
  | Some x -> Printf.printf "%f\n" x

let _ =
  let target_path = CD.Path.parse "A:B:C:D" |> Option.get in
  let cov = CD.Coverage.read Sys.argv.(1) in
  let avg_dist = CD.AverageDistance.distance target_path cov in
  let min_dist = CD.MinDistance.distance target_path cov in

  Format.printf "%a@." CD.AverageDistance.pp avg_dist;
  Format.printf "%a@." CD.MinDistance.pp min_dist;
  CD.Coverage.cover_target target_path cov |> Printf.printf "%b\n";

  ()
