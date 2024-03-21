open Domain

(* count only paths which align with the target path *)
let score target_path cov =
  let module ScoreSet = Set.Make (Float) in
  let scores =
    Cov.fold
      (fun path accu ->
        let d = Path.equal_depth path target_path in
        if d = 0 then accu else ScoreSet.add (float_of_int d) accu)
      cov ScoreSet.empty
  in

  if ScoreSet.is_empty scores then Some 0.0
  else ScoreSet.max_elt scores |> Option.some

let compare score1 score2 =
  match (score1, score2) with
  | Some s1, Some s2 -> compare s1 s2
  | _ -> failwith "unreachable: dafl only returns real scores"
