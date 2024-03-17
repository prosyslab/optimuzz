module DistanceSetMin = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare (_, d1) (_, d2) = compare d1 d2
  end)
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
