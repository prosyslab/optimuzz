(** represents a path in the AST branch tree *)
module Path : sig
  type t

  val compare : t -> t -> int
  val parse : string -> t
  val length : t -> int
  val distance : t -> t -> int
  val distances : t -> t -> int list
end = struct
  type t = { file : string; func : string; path : string list }
  (** represents a line in the coverage file *)

  let compare = compare

  (** parse coverage lines and return parsed string list
    example: InstCombineCompares.cpp:visitICmpInst:50:0 ->
    \["InstCombineCompares.cpp" ; "visitICmpInst"; "50"; "0"\]
  *)
  let parse s =
    let chunks = String.split_on_char ':' s |> List.filter (( <> ) "") in
    match chunks with
    | file :: func :: path -> { file; func; path }
    | _ -> failwith ("ill-formed path" ^ s)

  (** file and func also count as a length *)
  let length l = 2 + List.length l.path

  (* how many same nodes along the path from the root
   * src : file1 ; func1 ; path1  ; path2  ; ...
   dst : file2 ; func2 ; path1' ; path2' ; ... *)
  let equal_depth src dst =
    let rec fold acc l1 l2 =
      match (l1, l2) with
      | hd1 :: tl1, hd2 :: tl2 when hd1 = hd2 -> fold (acc + 1) tl1 tl2
      | _ -> acc
    in

    if src.file <> dst.file then 0
    else if src.func <> dst.func then 1
    else fold 2 src.path dst.path

  (** [distance src dst] returns the distance of two nodes in a tree *)
  let distance src dst =
    let p = equal_depth src dst in
    length src - p + (length dst - p)

  let distances src dst =
    let p = equal_depth src dst in
    let upper = List.init p (fun i -> i + p) in
    let lower = List.init (length src - p) (fun i -> i + p) in
    upper @ lower
end

module Coverage : sig
  type t

  val empty : t
  val cardinal : t -> int
  val union : t -> t -> t
  val read : string -> t
  val score : Path.t -> t -> int option
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

  let sum_cnt =
    List.fold_left (fun (total, cnt) x -> (total + x, cnt + 1)) (0, 0)

  let score target_path cov =
    let total, cnt =
      fold
        (fun path (total, cnt) ->
          let sub_total, sub_cnt = Path.distances path target_path |> sum_cnt in
          (total + sub_total, sub_cnt + cnt))
        cov (0, 0)
    in

    Format.eprintf "total: %d, cnt: %d@." total cnt;

    if cnt = 0 then None else Some (total / cnt)

  let cover_target = mem
end
