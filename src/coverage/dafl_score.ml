open Domain

(* count only paths which align with the target path *)
let score target_path cov =
  let module ScoreSet = Set.Make (Int) in
  let scores =
    Cov.fold
      (fun path accu ->
        let d = Path.equal_depth path target_path in
        if d = 0 then accu else ScoreSet.add d accu)
      cov ScoreSet.empty
  in

  ScoreSet.fold
    (fun x accu -> match accu with None -> Some x | Some y -> Some (x + y))
    scores None

let compare score1 score2 =
  match (score1, score2) with
  | None, None -> 0
  | None, Some _ -> 1
  | Some _, None -> -1
  | Some s1, Some s2 -> compare s1 s2
