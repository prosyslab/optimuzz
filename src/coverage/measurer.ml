open Domain
module F = Format

let cmd = Util.LUtil.command_args
let clean () = cmd [ "rm"; "cov.cov"; "2>/dev/null" ] |> ignore

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
  ( (List.hd chunks, chunks |> List.tl |> List.hd),
    List.nth chunks 2 |> int_of_string )

(* assume source codes are instrumented and `opt` are executed already *)
let run () =
  (* each line is form of [file_name:function_name:id] *)
  try
    let file = open_in "cov.cov" in
    let rec aux accu =
      match input_line file with
      | line ->
          let loc, id = parse_line line in
          aux
            (CovMap.update loc
               (function
                 | Some group -> Some (Group.add id group)
                 | None -> Some (Group.singleton id))
               accu)
      | exception End_of_file ->
          close_in file;
          accu
    in
    aux CovMap.empty
  with Sys_error _ -> CovMap.empty
