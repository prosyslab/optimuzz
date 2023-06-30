(* tree of instructions, associating constraints to constants *)
(* 2 terminals, 1 nonterminal, 1 undetermined *)
(* TODO: non-operator nonterminals *)
type pat_t =
  (* Any allows Const, Var, or Operator. Undetermined yet. *)
  | Any
  (* Const: constant; string is used only for debugging *)
  | Const of string * (int -> bool)
  (* Var: variable; includes undef and poison *)
  | Var of string
  (* Operator: opcode and operands; bool indicates commutativity. *)
  | Operator of Llvm.Opcode.t * bool * pat_t list

let string_of_pat pat =
  let rec aux nSpaces pat =
    let indent = String.make nSpaces ' ' in
    indent
    ^
    match pat with
    | Any -> "ANYTHING"
    | Const (name, _) -> name
    | Var name -> name
    | Operator (opcode, sps) ->
        Utils.string_of_opcode opcode
        ^ "(\n"
        ^ (nSpaces + 2 |> aux |> (Fun.flip List.map) sps |> String.concat ",\n")
        ^ "\n" ^ indent ^ ")"
  in
  aux 0 pat

(* PARSING FUNCTIONS *)
(* do not care of inner/outer whitespaces, since they are removed initially *)
(* FIXME: inefficient *)

(** [brack s] splits string [s]
    of form ["a(b(), c(d), e(f, g))"] into [("a", Some ["b()"; "c(d)"; "e(f, g)"])].
    If [s] does not open parenthesis, returns [(s, None)].
    @raise Invalid_argument if parentheses in [s] are not properly matched. *)
let brack s =
  let open String in
  if exists (( = ) '(') s then (
    let idx_open = index s '(' in
    let s_outer = sub s 0 idx_open in
    let s_inner = sub s (idx_open + 1) (length s - idx_open - 2) in
    let _, depth_end, idxs_cut =
      fold_left
        (fun (idx, depth, accu) c ->
          if depth = 0 && c = ',' then (idx + 1, depth, idx :: accu)
          else if c = '(' then (idx + 1, depth + 1, accu)
          else if c = ')' then (idx + 1, depth - 1, accu)
          else (idx + 1, depth, accu))
        (0, 0, []) s_inner
    in
    if depth_end <> 0 then raise (Invalid_argument s);
    let chunk0, chunks =
      List.fold_left
        (fun (s, accu) idx_cut ->
          (sub s 0 idx_cut, sub s (idx_cut + 1) (length s - idx_cut - 1) :: accu))
        (s_inner, []) idxs_cut
    in
    (s_outer, Some (if chunk0 = "" then [] else chunk0 :: chunks)))
  else (s, None)

let rec parse_single_match pat_raw =
  let name, sps_raw_opt = brack pat_raw in
  (* TODO: handle more cases *)
  match sps_raw_opt with
  | Some sps_raw -> (
      if sps_raw = [] then
        match name with
        | "m_Value" -> Any
        | "m_Undef" -> Var "UNDEF"
        | "m_Poison" -> Var "POISON"
        | "m_Constant" -> Const ("Any constant", Fun.const true)
        | "m_AllOnes" -> Const ("-1", ( = ) (-1))
        | "m_Negative" -> Const ("Negative", ( < ) 0)
        | "m_NonNegative" -> Const ("Nonnegative", ( >= ) 0)
        | "m_StrictlyPositive" -> Const ("Positive", ( > ) 0)
        | "m_NonPositive" -> Const ("Nonpositive", ( <= ) 0)
        | "m_One" -> Const ("1", ( = ) 1)
        | "m_Power2" -> Const ("2^n", fun x -> x > 0 && x land (x - 1) = 0)
        | "m_Power2OrZero" ->
            Const ("2^n (or zero)", fun x -> x land (x - 1) = 0)
        | "m_Zero" -> Const ("0", ( = ) 0)
        | _ -> raise (Invalid_argument name)
      else
        let sps = List.map parse_single_match sps_raw in
        match name with
        | "m_Value" | "m_Specific" -> List.hd sps
        | _ ->
            Operator
              ( Utils.opcode_of_string
                  (String.sub name 2 (String.length name - 2)),
                false,
                sps ))
  | None -> Var name

let parse pat_filename =
  (* read all lines from file *)
  let pat_file = open_in pat_filename in
  let rec loop accu =
    try loop (input_line pat_file :: accu) with End_of_file -> accu
  in
  let lines = loop [] in
  close_in pat_file;

  (* parse each match *)
  let opcode_str = List.hd lines in
  let pats =
    lines |> List.tl
    |> List.rev_map (fun line ->
           let _, inner_paren = brack line in
           let inner_paren = Option.get inner_paren in
           let name = List.hd inner_paren in
           let pat_raw = inner_paren |> List.tl |> List.hd in
           ( name,
             pat_raw
             |> Str.global_replace (Str.regexp " ") ""
             |> parse_single_match ))
  in

  (* TODO: associate by root operator *)
  pats

(* INSTANTIATION *)
(* Here, 'instance' means LLModule of a single function. *)

let instantiate (pat : pat_t) : Llvm.llmodule =
  let module ParamMap = Map.Make (String) in
  let llctx = Llvm.create_context () in
  let llm = Llvm.create_module llctx "test" in
  let i32 = Llvm.i32_type llctx in

  (* find all variables in the pattern *)
  let rec number_vars m p =
    match p with
    | Var name ->
        if ParamMap.mem name m then m
        else ParamMap.add name (ParamMap.cardinal m) m
    | Operator (_, _, sps) -> List.fold_left number_vars m sps
    | _ -> m
  in
  let param_idx_map = number_vars ParamMap.empty pat in

  (* define the function *)
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
  (* TODO: concretize this *)
  let const_of = Llvm.const_int i32 in
  let rec aux = function
    | Any -> Llvm.const_int i32 0
    | Const (_, cstr) ->
        if cstr (-1) then const_of (-1)
        else if cstr 0 then const_of 0
        else if cstr 1 then const_of 1
        else raise Not_found
    | Var name -> ParamMap.find name param_llv_map
    | Operator (opcode, _, sps) -> (
        let sp_instances = List.map aux sps in
        let open Utils.OpcodeClass in
        match classify opcode with
        | ARITH ->
            build_arith opcode (List.nth sp_instances 0)
              (List.nth sp_instances 1) builder
        | LOGIC ->
            build_logic opcode (List.nth sp_instances 0)
              (List.nth sp_instances 1) builder
        | _ -> failwith "Not implemented")
  in
  Llvm.build_ret (aux pat) builder |> ignore;
  llm
