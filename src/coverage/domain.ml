module Coverage : sig
  type t

  val empty : t
  val cardinal : t -> int
  val union : t -> t -> t
  val read : string -> t
  val avg_score : Path.t -> t -> float option
  val min_score : Path.t -> t -> float option
  val cover_target : Path.t -> t -> bool
end = struct
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
  let avg_score target_path cov =
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

  (* TODO: improve algorithm *)
  let min_score target_path cov =
    let distances : DistanceSetMin.t =
      fold
        (fun path accu ->
          let ds = Path.distances path target_path |> List.to_seq in
          accu |> DistanceSetMin.add_seq ds)
        cov DistanceSetMin.empty
    in
    if DistanceSetMin.is_empty distances then None
    else
      let _, min = DistanceSetMin.min_elt distances in
      Some (float_of_int min)

  let cover_target = mem
end
