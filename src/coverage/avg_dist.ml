open Domain

module DistanceSet = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare = compare
  end)

  let sum_cnt s =
    (0, 0) |> fold (fun (_path, dist) (total, cnt) -> (total + dist, cnt + 1)) s
end

(* TODO: improve algorithm *)
let score target_path cov =
  let distances : DistanceSet.t =
    Cov.fold
      (fun path accu ->
        let ds = Path.distances path target_path |> List.to_seq in
        accu |> DistanceSet.add_seq ds)
      cov DistanceSet.empty
  in
  let total, cnt = DistanceSet.sum_cnt distances in
  if cnt = 0 then None
  else
    let avg = float_of_int total /. float_of_int cnt in
    Some avg

let compare score1 score2 =
  match (score1, score2) with
  | None, None -> 0
  | None, _ -> 1
  | _, None -> -1
  | Some s1, Some s2 -> -compare s1 s2
