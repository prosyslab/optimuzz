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

(** [build_alloca_instr llctx instr] create and return allocation instruction. *)
let build_alloca_instr llctx instr =
  let inttype = Llvm.i32_type llctx in
  Llvm.build_alloca inttype "" (Llvm.builder_before llctx instr)

(** [build_load_instr llctx instr] create load instruction
    with randomly chosen pointer
    return instr[instr] when ptr does not exist. *)
let build_load_instr llctx instr =
  let list = Utils.get_alloca_from_function instr in
  match list with
  | [] -> instr
  | _ ->
      Llvm.build_load (Utils.list_random list) ""
        (Llvm.builder_before llctx instr)

(** [build_store_instr llctx instr] create store instruction which
    store random variable to random ptr
    return instr[instr] when variable or ptr does not exist. *)
let build_store_instr llctx instr =
  let arg_list = Utils.get_assignments_before instr in
  let allo_list = Utils.get_alloca_from_function instr in
  if arg_list <> [] && allo_list <> [] then
    Llvm.build_store
      (Utils.list_random arg_list)
      (Utils.list_random allo_list)
      (Llvm.builder_before llctx instr)
  else instr
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
  match l with
  | [] -> Llvm.const_int inttype c
  | _ -> Utils.list_random [ Utils.list_random l; Llvm.const_int inttype c ]

(** [create_random_instr instr] create
    a random binary integer arithmetic operation [instr]
    with a list of arguments declared before instr.
    Returns the new instruction. *)
let create_random_instr llctx instr =
  let list = Utils.get_assignments_before instr in
  let opcode = Utils.random_opcode_except None in
  create_arith_instr llctx instr opcode
    (modify_value llctx (Llvm.operand instr 0) list)
    (modify_value llctx (Llvm.operand instr 1) list)

(** [substitute_operand instr] substitutes
    operand of instruction with another integer value
    Return origin instr[instr]. *)
let substitute_operand llctx instr =
  let list = Utils.get_assignments_before instr in
  (if Utils.OpcodeClass.classify (Llvm.instr_opcode instr) = ARITH && list <> []
  then
   (* If there is no previously declared argument, instruction is constant*)
   let i = Random.int 2 in
   Llvm.set_operand instr i (modify_value llctx (Llvm.operand instr i) list));
  instr

let run llctx llm =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  let f =
    (* assume the sole function *)
    match Llvm.function_begin llm_clone with
    | Before f -> f
    | At_end _ -> failwith "No function defined"
  in
  let arith_instr_list =
    Utils.fold_left_all_instr
      (fun a i ->
        if
          i |> Llvm.instr_opcode |> Utils.OpcodeClass.classify
          = Utils.OpcodeClass.ARITH
        then i :: a
        else a)
      [] f
  in
  let i =
    match arith_instr_list with
    | [] -> Utils.get_return_instr f
    | _ -> Utils.list_random arith_instr_list
  in
  let mutate_fun =
    Utils.list_random
      [
        (fun i -> ignore (substitute_operand llctx i));
        (fun i ->
          i |> Llvm.instr_opcode |> Option.some |> Utils.random_opcode_except
          |> substitute_arith_instr llctx i
          |> ignore);
        (fun i -> ignore (create_random_instr llctx i));
        (fun i -> ignore (build_alloca_instr llctx i));
        (fun i -> ignore (build_load_instr llctx i));
        (fun i -> ignore (build_store_instr llctx i));
      ]
  in
  mutate_fun i;
  llm_clone

