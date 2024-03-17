open Domain

module DistanceSetMin = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare (_, d1) (_, d2) = compare d1 d2
  end)
end

(* TODO: improve algorithm *)
let score target_path cov =
  let distances : DistanceSetMin.t =
    Cov.fold
      (fun path accu ->
        let ds = Path.distances path target_path |> List.to_seq in
        accu |> DistanceSetMin.add_seq ds)
      cov DistanceSetMin.empty
  in
  if DistanceSetMin.is_empty distances then Infinity
  else
    let _, min = DistanceSetMin.min_elt distances in
    Real (float_of_int min)

let compare score1 score2 =
  match (score1, score2) with
  | Infinity, Infinity -> 0
  | Infinity, _ -> 1
  | _, Infinity -> -1
  | Real s1, Real s2 -> compare s1 s2
