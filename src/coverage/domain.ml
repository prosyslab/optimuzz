(** represents a path in the AST branch tree *)
module Path : sig
  type t

  val compare : t -> t -> int
  val parse : string -> t
  val length : t -> int
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
    | file :: func :: ids -> file :: func :: ids
    | _ -> failwith ("ill-formed path" ^ s)

  (** file and func also count as a length *)
  let length = List.length

  (* how many same nodes along the path from the root
   * src : file1 ; func1 ; path1  ; path2  ; ...
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
    length src - p + (length dst - p)

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
      | line ->
          let path = Path.parse line in
          add path accu |> aux
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
    let distances : DistanceSet.t =
      fold
        (fun path accu ->
          let ds = Path.distances path target_path |> List.to_seq in
          accu |> DistanceSet.add_seq ds)
        cov DistanceSet.empty
    in
    if DistanceSet.is_empty distances then None
    else
      let _, min = DistanceSet.min_elt distances in
      Some (float_of_int min)

  let cover_target = mem
end
