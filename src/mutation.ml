(** [create_arith_instr llctx instr opcode operand0 operand1] creates
    a binary integer arithmetic operation (opcode [opcode])
    right before [instr], with operands [operand0] and [operand1].
    It does not use extra keywords such as nsw, nuw, exact, etc.
    Returns the new instruction. *)
let create_arith_instr llctx instr opcode operand0 operand1 =
  (Utils.OpcodeClass.build_arith_op opcode)
    operand0 operand1 ""
    (Llvm.builder_before llctx instr)

(** [substitute_instr llctx instr opcode] substitutes
    a binary integer arithmetic operation [instr]
    into another operation (with opcode [opcode]).
    It does not use extra keywords such as nsw, nuw, exact, etc.
    Returns the new instruction. *)
let substitute_arith_instr llctx instr opcode =
  let new_instr =
    (Utils.OpcodeClass.build_arith_op opcode)
      (Llvm.operand instr 0) (Llvm.operand instr 1) ""
      (Llvm.builder_before llctx instr)
  in
  Llvm.replace_all_uses_with instr new_instr;
  Llvm.delete_instruction instr;
  new_instr

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
