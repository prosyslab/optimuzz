type pat_t =
  | Const of int
  | Variable of string
  | Operator of Llvm.Opcode.t * pat_t list

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
  | "m_Value" | "m_Specific" | "m_APInt" -> Variable arg
  | _ -> raise (Invalid_argument name)

(* TODO: Handle aliases e.g., m_Not *)
(* TODO: Handle commutative versions e.g., m_c_Add *)
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

let generate_simplest pat : Llvm.llmodule =
  let llctx = Llvm.create_context () in
  let llm = Llvm.create_module llctx "test" in
  let i32 = Llvm.i32_type llctx in

  (* find all variables in the pattern *)
  let module ParamMap = Map.Make (String) in
  let rec number_vars m p =
    match p with
    | Const _ -> m
    | Variable v ->
        if ParamMap.mem v m then m else ParamMap.add v (ParamMap.cardinal m) m
    | Operator (_, sps) -> List.fold_left number_vars m sps
  in
  let param_idx_map = number_vars ParamMap.empty pat in

  let f =
    Llvm.define_function "f"
      (Llvm.function_type i32
         (Array.make (ParamMap.cardinal param_idx_map) i32))
      llm
  in
  let param_llv_map =
    ParamMap.mapi
      (fun param idx ->
        let llv = Llvm.param f idx in
        Llvm.set_value_name param llv;
        llv)
      param_idx_map
  in
  let builder = Llvm.builder_at_end llctx (Llvm.entry_block f) in

  (* Postorder traversal of the tree. Involves parameter introduction. *)
  let rec aux (p : pat_t) : Llvm.llvalue =
    match p with
    | Const i -> Llvm.const_int i32 i
    | Variable v -> ParamMap.find v param_llv_map
    | Operator (opcode, sps) -> (
        let operands = List.map aux sps in
        (* TODO: handle non-binary operators *)
        let o0 = List.hd operands in
        let o1 = operands |> List.tl |> List.hd in
        match Utils.OpcodeClass.classify opcode with
        | ARITH -> Utils.OpcodeClass.build_arith opcode o0 o1 builder
        | LOGIC -> Utils.OpcodeClass.build_logic opcode o0 o1 builder
        | _ -> failwith "Not implemented")
  in
  Llvm.build_ret (aux pat) builder |> ignore;
  Llvm.print_module "test.ll" llm;
  failwith "2"
