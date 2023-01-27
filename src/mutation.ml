module OpCls = Utils.OpcodeClass

(** [create_arith_instr llctx loc opcode o0 o1] creates
    an ARITH instruction (opcode [opcode]) right before instruction [loc],
    with operands [o0] and [o1]. Does not use extra keywords.
    Returns the new instruction. *)
let create_arith_instr llctx loc opcode o0 o1 =
  (OpCls.build_arith opcode) o0 o1 "" (Llvm.builder_before llctx loc)

(** [subst_arith_instr llctx instr opcode] substitutes
    an arithmetic instruction [instr] into another one ([opcode]),
    with the same operands. Does not use extra keywords.
    Returns the new instruction. *)
let subst_arith_instr llctx instr opcode =
  let new_instr =
    create_arith_instr llctx instr opcode (Llvm.operand instr 0)
      (Llvm.operand instr 1)
  in
  Llvm.replace_all_uses_with instr new_instr;
  Llvm.delete_instruction instr;
  new_instr

(** [create_logic_instr llctx loc opcode o0 o1] creates
    a LOGIC instruction (opcode [opcode]) right before instruction [loc],
    with operands [o0] and [o1]. Does not use extra keywords.
    Returns the new instruction. *)
let create_logic_instr llctx loc opcode o0 o1 =
  (OpCls.build_logic opcode) o0 o1 "" (Llvm.builder_before llctx loc)

(** [subst_logic_instr llctx instr opcode] substitutes
    a logic instruction [instr] into another one ([opcode]).
    Does not use extra keywords.
    Returns the new instruction. *)
let subst_logic_instr llctx instr opcode =
  let new_instr =
    create_logic_instr llctx instr opcode (Llvm.operand instr 0)
      (Llvm.operand instr 1)
  in
  Llvm.replace_all_uses_with instr new_instr;
  Llvm.delete_instruction instr;
  new_instr

(** [create_cast_instr llctx loc opcode o ty] creates
    a cast instruction (opcode [opcode]) right before instruction [loc],
    with operands [o] and target type [ty].
    Returns the new instruction. *)
let create_cast_instr llctx loc opcode o ty =
  (OpCls.build_cast opcode) o ty "" (Llvm.builder_before llctx loc)

(* TODO: substitution *)

(** [create_cmp_instr llctx loc icmp o0 o1] creates
    a comparison instruction ([icmp]) right before instruction [loc],
    with operands [o0] and [o1].
    Returns the new instruction. *)
let create_cmp_instr llctx loc icmp o0 o1 =
  (OpCls.build_cmp icmp) o0 o1 "" (Llvm.builder_before llctx loc)

(** [subst_cmp_instr llctx instr icmp] substitutes
    a cmp instruction [instr] into another one ([icmp]).
    Returns the new instruction. *)
let subst_cmp_instr llctx instr icmp =
  let new_instr =
    create_cmp_instr llctx instr icmp (Llvm.operand instr 0)
      (Llvm.operand instr 1)
  in
  Llvm.replace_all_uses_with instr new_instr;
  Llvm.delete_instruction instr;
  new_instr

(** [create_alloca_instr llctx loc] creates
    an alloca instruction right before instruction [loc].
    Returns the new instruction. *)
let create_alloca_instr llctx instr =
  Llvm.build_alloca (Llvm.i32_type llctx) "" (Llvm.builder_before llctx instr)

(** [create_load_instr llctx loc o] creates
    a load instruction right before instruction [loc], with operand [o].
    Returns the new instruction. *)
let create_load_instr llctx loc o =
  Llvm.build_load o "" (Llvm.builder_before llctx loc)

(** [create_store_instr llctx loc o0 o1] creates
    a store instruction right before instruction [loc],
    with operands [o0] (value) and [o1] (pointer).
    Return the new instruction. *)
let create_store_instr llctx loc o0 o1 =
  Llvm.build_store o0 o1 (Llvm.builder_before llctx loc)

(** [lower_instr llctx instr] lowers
    the given instruction [instr] one step down within its parent block.
    Returns its updated predecessor, i.e., its previous successor.
    If [instr] is the last instruction, does nothing and returns [instr]. *)
let lower_instr llctx instr =
  match Llvm.instr_succ instr with
  | At_end _ -> instr
  | Before instr_succ ->
      let instr_succ_clone = Llvm.instr_clone instr_succ in
      Llvm.insert_into_builder instr_succ_clone ""
        (Llvm.builder_before llctx instr);
      Llvm.replace_all_uses_with instr_succ instr_succ_clone;
      Llvm.set_value_name (Llvm.value_name instr_succ) instr_succ_clone;
      instr_succ_clone

(** [split_block llctx instr] splits the parent block of [instr] into two blocks
    and links them by unconditional branch.
    [instr] becomes the first instruction of the latter block.
    Returns the former block. *)
let split_block llctx instr =
  let block = Llvm.instr_parent instr in
  let new_block = Llvm.insert_block llctx "" block in
  let builder = Llvm.builder_at_end llctx new_block in
  Llvm.position_before (Llvm.build_br block builder) builder;
  let rec aux () =
    match Llvm.instr_begin block with
    | Llvm.Before i when i = instr -> ()
    | Llvm.Before i ->
        let i_clone = Llvm.instr_clone i in
        Llvm.insert_into_builder i_clone "" builder;
        Llvm.replace_all_uses_with i i_clone;
        Llvm.delete_instruction i;
        aux ()
    | Llvm.At_end _ -> failwith "NEVER OCCUR"
  in
  aux ();
  new_block

(** [make_conditional llctx instr] substitutes
    an unconditional branch instruction [instr]
    into trivial conditional branch instruction.
    Returns the conditional branch instruction. *)
let make_conditional llctx instr =
  let block = Llvm.instr_parent instr in
  match instr |> Llvm.get_branch |> Option.get with
  | `Unconditional target_block ->
      let fbb = Llvm.append_block llctx "" (Llvm.block_parent block) in
      Llvm.move_block_after target_block fbb;
      ignore (Llvm.build_unreachable (Llvm.builder_at_end llctx fbb));
      Llvm.delete_instruction instr;
      Llvm.build_cond_br
        (Llvm.const_int (Llvm.i1_type llctx) 1)
        target_block fbb
        (Llvm.builder_at_end llctx block)
  | `Conditional _ -> failwith "Conditional branch already"

(** [make_unconditional llctx instr] substitutes
    a conditional branch instruction [instr]
    into unconditional branch instruction targets for true-branch.
    Returns the unconditional branch instruction. *)
let make_unconditional llctx instr =
  match instr |> Llvm.get_branch |> Option.get with
  | `Conditional (_, target_block, _) ->
      Llvm.delete_instruction instr;
      Llvm.build_br target_block
        (Llvm.builder_at_end llctx (Llvm.instr_parent instr))
  | `Unconditional _ -> failwith "Unconditional branch already"

(** [negate_condition llctx instr] negates the condition of
    the conditional branch instruction [instr].
    Returns [instr] (with its condition negated). *)
let negate_condition llctx instr =
  match instr |> Llvm.get_branch |> Option.get with
  | `Conditional (cond, _, _) ->
      Llvm.set_condition instr
        (Llvm.build_not cond "" (Llvm.builder_before llctx instr));
      instr
  | `Unconditional _ -> failwith "Unconditional branch"

(** [modify_value llctx v l] slightly modifies value [v]
    or returns a random element of [l]. *)
let modify_value llctx v l =
  let inttype = Llvm.i32_type llctx in
  let c =
    match Llvm.int64_of_const v with
    | Some con -> (
        match Random.int 3 with
        | 0 -> Int64.to_int con * 2
        | 1 -> Int64.to_int con * -1
        | _ -> Int64.to_int con + 1)
    | None -> Random.int 200 - 100
  in
  if l <> [] then
    Utils.list_random [ Utils.list_random l; Llvm.const_int inttype c ]
  else Llvm.const_int inttype c

(** [create_random_instr llctx instr] creates
    a random instruction before instruction [loc],
    with lists of available arguments declared prior to [loc].
    Returns the new instruction. *)
let create_random_instr llctx instr =
  let i32 = Llvm.i32_type llctx in
  let zero = Llvm.const_int i32 0 in
  let null = Llvm.const_pointer_null i32 in
  let assignments = Utils.get_assignments_before instr in
  let allocations = Utils.get_alloca_from_function instr in
  let opcode = OpCls.random_opcode_except None in
  match OpCls.classify opcode with
  | OpCls.TER -> failwith "Not implemented"
  | ARITH ->
      create_arith_instr llctx instr opcode
        (modify_value llctx zero assignments)
        (modify_value llctx zero assignments)
  | LOGIC ->
      create_logic_instr llctx instr opcode
        (modify_value llctx zero assignments)
        (modify_value llctx zero assignments)
  | MEM -> (
      match opcode with
      | Alloca -> create_alloca_instr llctx instr
      | Load ->
          create_load_instr llctx instr
            (if allocations <> [] then Utils.list_random allocations else null)
      | Store ->
          create_store_instr llctx instr
            (modify_value llctx zero assignments)
            (if allocations <> [] then Utils.list_random allocations else null)
      | _ -> failwith "NEVER OCCUR")
  | CAST ->
      (* TODO *)
      create_cast_instr llctx instr opcode
        (modify_value llctx zero assignments)
        (Llvm.i32_type llctx)
  | CMP ->
      create_cmp_instr llctx instr
        (Utils.list_random
           [ Llvm.Icmp.Eq; Ne; Ugt; Uge; Ult; Ule; Sgt; Sge; Slt; Sle ])
        (modify_value llctx zero assignments)
        (modify_value llctx zero assignments)
  | PHI -> failwith "Not implemented"
  | OTHER -> failwith "Not implemented"

(** [subst_operand instr] substitutes
    an operand of (arithmetic) instruction [instr] with another available one.
    Returns [instr] (with its operand changed). *)
let subst_operand llctx instr =
  let list = Utils.get_assignments_before instr in
  (if Utils.OpcodeClass.classify (Llvm.instr_opcode instr) = ARITH && list <> []
  then
   (* If there is no previously declared argument, instruction is constant*)
   let i = Random.int 2 in
   Llvm.set_operand instr i (modify_value llctx (Llvm.operand instr i) list));
  instr

let run llctx llm =
  let open Utils in
  let llm_clone = Llvm_transform_utils.clone_module llm in
  let f = Utils.choose_function llm_clone in
  let arith_instrs = Utils.all_arith_instrs_of f in
  let i =
    if arith_instrs <> [] then Utils.list_random arith_instrs
    else Utils.get_return_instr f
  in
  let mutate_fun =
    Utils.list_random
      [
        (fun i -> i >> subst_operand llctx);
        (fun i ->
          i |> Llvm.instr_opcode |> Option.some |> OpCls.random_opcode_except
          >> subst_arith_instr llctx i);
        (fun i -> i >> create_random_instr llctx);
      ]
  in
  mutate_fun i;
  llm_clone
