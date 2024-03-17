module DistanceSet = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare = compare
  end)

  let sum_cnt s =
    (0, 0) |> fold (fun (_path, dist) (total, cnt) -> (total + dist, cnt + 1)) s
end

include Set.Make (Path)

let read file =
  let ic = open_in file in
  let rec aux accu =
    match input_line ic with
    | line -> (
        match Path.parse line with
        | Some path -> add path accu |> aux
        | None -> aux accu)
    | exception End_of_file -> accu
  in
  let cov = aux empty in
  close_in ic;
  cov

(* TODO: improve algorithm *)
let score target_path cov =
  let distances : DistanceSet.t =
    fold
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

let cover_target = mem
