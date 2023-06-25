type tree =
  | Const of int
  | Variable of string
  | Operator of Llvm.Opcode.t * tree list

let rec string_of_tree = function
  | Const i -> "Const(" ^ string_of_int i ^ ")"
  | Variable x -> x
  | Operator (opcode, children) ->
      Utils.string_of_opcode opcode
      ^ "["
      ^ String.concat ", " (List.map string_of_tree children)
      ^ "]"

let to_node name arg =
  match name with
  | "m_One" -> Const 1
  | "m_Zero" -> Const 0
  | "m_Value" -> Variable arg
  | _ -> raise (Invalid_argument name)

let to_opcode name =
  Utils.opcode_of_string (String.sub name 2 (String.length name - 2))

let parse pat_filename =
  let open String in
  let pat_file = open_in pat_filename in
  let pat_raw = input_line pat_file |> Str.global_replace (Str.regexp " ") "" in
  close_in pat_file;

  let pos_cut = index pat_raw ',' in
  let name = sub pat_raw 6 (pos_cut - 6) in
  let pat = sub pat_raw (pos_cut + 1) (length pat_raw - pos_cut - 2) in

  (* TODO: inefficient *)
  let rec build p =
    (* PATTERN = NAME(SUBPATTERN) *)
    let pos_open = index p '(' in
    let name = sub p 0 pos_open in
    let sp = sub p (pos_open + 1) (length p - pos_open - 2) in

    if contains sp '(' then
      (* there are more subpatterns *)
      let _, _, poss_cut =
        fold_left
          (fun (idx, depth, accu) c ->
            if depth = 0 && c = ',' then (idx + 1, depth, idx :: accu)
            else if c = '(' then (idx + 1, depth + 1, accu)
            else if c = ')' then (idx + 1, depth - 1, accu)
            else (idx + 1, depth, accu))
          (0, 0, []) sp
      in
      let arg, args =
        List.fold_left
          (fun (s, accu) pos_cut ->
            ( sub s 0 pos_cut,
              sub s (pos_cut + 1) (length s - pos_cut - 1) :: accu ))
          (sp, []) poss_cut
      in
      let args = arg :: args in
      Operator (to_opcode name, List.map build args)
    else to_node name sp
  in
  (name, build pat)
