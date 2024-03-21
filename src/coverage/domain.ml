module Path : sig
  type t

  val compare : t -> t -> int
  val parse : string -> t option
  val equal_depth : t -> t -> int
  val distances : t -> t -> (t * int) list
  val pp : Format.formatter -> t -> unit
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

  let pp fmt t = Format.fprintf fmt "%s" (String.concat " ; " t)
end

module Cov = struct
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

  let cover_target = mem
end

type score_t = float option

module type METRIC = sig
  val score : Path.t -> Cov.t -> score_t
  val compare : score_t -> score_t -> int
end

let pp_score fmt (score : score_t) =
  match score with
  | Some f -> Format.fprintf fmt "%f" f
  | None -> Format.fprintf fmt "None"
