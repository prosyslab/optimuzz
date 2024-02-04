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

module type DISTANCE_SET = sig
  type elt = Path.t * int
  type t
  type result

  val empty : t
  val add : elt -> t -> t
  val add_seq : elt Seq.t -> t -> t
  val metric : t -> result option
end

module DistanceSetAvg : DISTANCE_SET with type result = float = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare = compare
  end)

  type result = float

  let sum_cnt s =
    (0, 0) |> fold (fun (_path, dist) (total, cnt) -> (total + dist, cnt + 1)) s

  let metric s =
    let total, cnt = sum_cnt s in
    if cnt = 0 then None else Some (float_of_int total /. float_of_int cnt)
end

module DistanceSetMin : DISTANCE_SET with type result = int = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare (_, d1) (_, d2) = compare d1 d2
  end)

  type result = int

  let metric s =
    let _, min_dist = min_elt s in
    if is_empty s then None else Some min_dist
end

module Coverage (Distances : DISTANCE_SET) : sig
  type t
  type metric = Distances.result

  val empty : t
  val cardinal : t -> int
  val union : t -> t -> t
  val read : string -> t
  val score : Path.t -> t -> metric option
  val cover_target : Path.t -> t -> bool
end = struct
  include Set.Make (Path)

  type metric = Distances.result

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
  let score target_path cov =
    let distances : Distances.t =
      fold
        (fun path accu ->
          let ds = Path.distances path target_path |> List.to_seq in
          accu |> Distances.add_seq ds)
        cov Distances.empty
    in
    Distances.metric distances

  let cover_target = mem
end

module CoverageAvg = Coverage (DistanceSetAvg)
module CoverageMin = Coverage (DistanceSetMin)
