(* simple tree for pattern *)
type pat_t = Terminal of string | Nonterminal of string * pat_t list

let rec string_of_pat = function
  | Terminal name -> name
  | Nonterminal (name, sps) ->
      name ^ "(" ^ String.concat ", " (List.map string_of_pat sps) ^ ")"

let parse pat_filename =
  let open String in
  let pat_file = open_in pat_filename in
  let pat_raw = input_line pat_file |> Str.global_replace (Str.regexp " ") "" in
  close_in pat_file;

  let pos_cut = index pat_raw ',' in
  let name = sub pat_raw 6 (pos_cut - 6) in
  let pat_str = sub pat_raw (pos_cut + 1) (length pat_raw - pos_cut - 2) in

  (* TODO: inefficient *)
  let rec aux p =
    (* each pattern is form of Pattern(SubPattern(), SubPattern(SubPattern)) *)
    if contains p '(' then
      let pos_open = index p '(' in
      let name = sub p 0 pos_open in
      let sp = sub p (pos_open + 1) (length p - pos_open - 2) in
      if sp = "" then Terminal name
      else
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
        Nonterminal (name, List.map aux args)
    else Terminal p
  in
  (name, aux pat_str)

module ParamMap = Map.Make (String)

let instantiate_terminal ty name =
  match name with
  | "m_Undef" -> Llvm.undef ty
  | "m_Poison" -> Llvm.poison ty
  | "m_Zero" -> Llvm.const_int ty 0
  | "m_One" -> Llvm.const_int ty 1
  | "m_AllOnes" -> Llvm.const_int ty 0xFFFFFFFF
  | _ -> raise (Invalid_argument name)

let instantiate_nonterminal name subpat_instances builder =
  let opcode =
    String.sub name 2 (String.length name - 2)
    |> Str.global_replace (Str.regexp "_c_") "_"
    |> Utils.opcode_of_string
  in
  match Utils.OpcodeClass.classify opcode with
  | ARITH ->
      Utils.OpcodeClass.build_arith opcode (List.hd subpat_instances)
        (subpat_instances |> List.tl |> List.hd)
        builder
  | LOGIC ->
      Utils.OpcodeClass.build_logic opcode (List.hd subpat_instances)
        (subpat_instances |> List.tl |> List.hd)
        builder
  | _ -> (
      (* TODO: handle more cases *)
      match name with
      | "m_Value" | "m_Specific" | "m_APInt" -> List.hd subpat_instances
      | _ -> raise (Invalid_argument name))

let instantiate pat =
  let llctx = Llvm.create_context () in
  let llm = Llvm.create_module llctx "test" in
  let i32 = Llvm.i32_type llctx in

  (* find all variables in the pattern *)
  let rec number_vars m p =
    match p with
    | Terminal name ->
        if String.starts_with ~prefix:"m_" name || ParamMap.mem name m then m
        else ParamMap.add name (ParamMap.cardinal m) m
    | Nonterminal (_, sps) -> List.fold_left number_vars m sps
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

  (* postorder traversal involving instruction generation *)
  let rec aux = function
    | Terminal name -> (
        match ParamMap.find_opt name param_llv_map with
        | Some llv -> llv
        | None -> instantiate_terminal i32 name)
    | Nonterminal (name, sps) ->
        let sp_instances = List.map aux sps in
        instantiate_nonterminal name sp_instances builder
  in
  Llvm.build_ret (aux pat) builder |> ignore;
  llm
