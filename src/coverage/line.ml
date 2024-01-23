type t = { file : string; func : string; path : string list }

(** parse coverage lines and return parsed string list
    example: InstCombineCompares.cpp:visitICmpInst:50:0 ->
    \["InstCombineCompares.cpp" ; "visitICmpInst"; "50"; "0"\]
*)
let parse s =
  let chunks = String.split_on_char ':' s |> List.filter (( <> ) "") in
  match chunks with
  | file :: func :: path -> { file; func; path }
  | _ -> failwith "ill-formed coverage line"

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
