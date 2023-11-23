open Domain
module F = Format

let cmd = Util.AUtil.command_args
let clean () = cmd [ "rm"; "cov.cov"; "2>/dev/null" ] |> ignore

(** parse coverage lines and return parsed string list
  example: InstCombineCompares.cpp:visitICmpInst:50_0 -> [InstCombineCompares.cpp ; visitICmpInst; 50; 0]
    *)
let parse_line line =
  let chunks = String.split_on_char ':' line in
  let chunks =
    match List.length chunks with
    | 3 -> chunks
    | 4 ->
        let chunks_filtered = List.filter (( <> ) "") chunks in
        if List.length chunks_filtered = 3 then chunks_filtered
        else failwith "Invalid coverage line"
    | _ -> failwith "Invalid coverage line"
  in
  let cov_tree = List.nth chunks 2 in
  [ List.nth chunks 0; List.nth chunks 1 ] @ String.split_on_char '_' cov_tree

(** get distance on tree *)
let get_distance seed =
  let target = parse_line !Config.cov_directed in
  let equal_depth =
    let rec fold idx =
      if idx = min (List.length seed) (List.length target) then idx
      else if List.nth seed idx <> List.nth target idx then idx
      else fold (idx + 1)
    in
    fold 0
  in
  let distance =
    List.length seed - equal_depth + (List.length target - equal_depth)
  in
  distance

(* assume source codes are instrumented and `opt` are executed already *)
let run () =
  (* each line is form of [file_name:function_name:id] *)
  try
    let file = open_in "cov.cov" in
    let rec aux accu =
      match input_line file with
      | line ->
          let parsed_line = parse_line line in
          aux (CovSet.add (get_distance parsed_line) accu)
      | exception End_of_file ->
          close_in file;
          if CovSet.is_empty accu then CovSet.singleton !Config.max_distance
          else accu
    in
    aux CovSet.empty
  with Sys_error _ -> CovSet.singleton !Config.max_distance
