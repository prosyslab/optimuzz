(** represents a path in the AST branch tree *)
module Path : sig
  type t

  val compare : t -> t -> int
  val parse : string -> t option
  val length : t -> int
  val diff : t -> t -> int
  val distance : t -> t -> int
  val distances : t -> t -> (t * int) list
end = struct
  type t = string list
  (** represents a line in the coverage file *)

  let compare = compare

  (** parse coverage lines and return parsed string list
    example: InstCombineCompares.cpp:visitICmpInst:50:0 ->
    \["InstCombineCompares.cpp" ; "visitICmpInst"; "50"; "0"\]
  *)
  let parse s =
    let chunks = String.split_on_char ':' s |> List.filter (( <> ) "") in
    match chunks with
    | file :: func :: ids -> file :: func :: ids |> Option.some
    | _ -> None

  (** file and func also count as a length *)
  let length = List.length

  (* how many same nodes along the path from the root
     src : file1 ; func1 ; path1  ; path2  ; ...
     dst : file2 ; func2 ; path1' ; path2' ; ... *)
  let equal_depth src dst =
    let rec fold acc l1 l2 =
      match (l1, l2) with
      | hd1 :: tl1, hd2 :: tl2 when hd1 = hd2 -> fold (acc + 1) tl1 tl2
      | _ -> acc
    in

    fold 0 src dst

  (** [distance src dst] returns the distance of two nodes in a tree *)
  let distance src dst =
    let p = equal_depth src dst in
    length dst - p + (length src - p)

  (** [diff src dst] returns the number of changes required from [src] path to [dst] path.
      - [diff [A;B;C] [A;E;F] = 2].
      - [diff [A;B;C] [A;B;C;D]] = 1.
      - [diff [A;B;C] [A;B;C]] = 0.
      - [diff [A;B;C] [A;B;C;D;E]] = 2.
      *)
  let diff src dst = length dst - equal_depth src dst

  let distances src dst =
    src (* [A; B; C] *)
    |> List.rev (* [C; B; A] *)
    |> List.fold_left (* [ A ; A :: B ; A :: B :: C ] *)
         (fun accu p -> [ p ] :: List.map (fun a -> p :: a) accu)
         []
    |> List.fold_left (* [ (A, n1); (A :: B, n2); (A :: B :: C; n3) ] *)
         (fun accu p -> (p, distance p dst) :: accu)
         []
end

module DistanceSet = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare = compare
  end)

  let sum_cnt s =
    (0, 0) |> fold (fun (_path, dist) (total, cnt) -> (total + dist, cnt + 1)) s
end

module Coverage = struct
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
    let module IntSet = Set.Make (Int) in
    let distances =
      fold
        (fun path accu ->
          let d = Path.diff path target_path in
          accu |> IntSet.add d)
        cov IntSet.empty
    in
    try
      let min = IntSet.min_elt distances in
      Some (float_of_int min)
    with Not_found -> None

  let cover_target = mem
end

module type Distance = sig
  type t

  val distance : Path.t -> Coverage.t -> t option
end

module AverageDistance : Distance with type t = float = struct
  type t = float

  let distance target cov =
    let distances : DistanceSet.t =
      Coverage.fold
        (fun path accu ->
          let ds = Path.distances path target |> List.to_seq in
          accu |> DistanceSet.add_seq ds)
        cov DistanceSet.empty
    in
    let total, cnt = DistanceSet.sum_cnt distances in
    if cnt = 0 then None
    else
      let avg = float_of_int total /. float_of_int cnt in
      Some avg
end

module MinDistance : Distance with type t = int = struct
  type t = int

  let distance target cov =
    let module IntSet = Set.Make (Int) in
    let distances =
      Coverage.fold
        (fun path accu ->
          let d = Path.diff path target in
          accu |> IntSet.add d)
        cov IntSet.empty
    in
    try
      let min = IntSet.min_elt distances in
      Some min
    with Not_found -> None
end
