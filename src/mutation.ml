module OpCls = Utils.OpcodeClass

(** [create_arith_instr llctx loc opcode o0 o1] creates
    an ARITH instruction (opcode [opcode]) right before instruction [loc],
    with operands [o0] and [o1]. Does not use extra keywords.
    Returns the new instruction. *)
let create_arith_instr llctx loc opcode o0 o1 =
  (OpCls.build_arith opcode) o0 o1 "" (Llvm.builder_before llctx loc)

(** [subst_arith_instr llctx instr opcode] substitutes
    an ARITH instruction [instr] into another one ([opcode]),
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
    a LOGIC instruction [instr] into another one ([opcode]).
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

(* There is no aggregated helper for building MEM instructions. *)

(** [create_cast_instr llctx loc opcode o ty] creates
    a CAST instruction (opcode [opcode]) right before instruction [loc],
    with operand [o] and target type [ty].
    Returns the new instruction. *)
let create_cast_instr llctx loc opcode o ty =
  (OpCls.build_cast opcode) o ty "" (Llvm.builder_before llctx loc)

(* TODO: what is the 'substitution' of cast instruction? *)

(** [create_cmp_instr llctx loc icmp o0 o1] creates
    a CMP instruction ([icmp]) right before instruction [loc],
    with operands [o0] and [o1].
    Returns the new instruction. *)
let create_cmp_instr llctx loc icmp o0 o1 =
  (OpCls.build_cmp icmp) o0 o1 "" (Llvm.builder_before llctx loc)

(** [subst_cmp_instr llctx instr icmp] substitutes
    a CMP instruction [instr] into another one ([icmp]).
    Returns the new instruction. *)
let subst_cmp_instr llctx instr icmp =
  let new_instr =
    create_cmp_instr llctx instr icmp (Llvm.operand instr 0)
      (Llvm.operand instr 1)
  in
  Llvm.replace_all_uses_with instr new_instr;
  Llvm.delete_instruction instr;
  new_instr

(** [create_phi_instr llctx loc incoming] creates
    a PHI instruction instruction at the beginning of block [loc],
    with [incoming].
    Returns the new instruction. *)
let create_phi_instr llctx loc incoming =
  OpCls.build_phi incoming ""
    (Llvm.builder_before llctx
       (match Llvm.instr_begin loc with
       | Before i -> i
       | At_end _ -> failwith "NEVER OCCUR"))

(* TODO: what is the 'substitution' of phi instruction? *)

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
    If [instr] is terminator or instruction right before terminator,
    does nothing and returns [instr]. *)
let lower_instr llctx instr =
  match Llvm.instr_succ instr with
  | At_end _ -> instr
  | Before instr_succ ->
      if instr_succ |> Llvm.instr_opcode |> OpCls.classify = OpCls.TER then
        instr
      else
        let instr_succ_clone = Llvm.instr_clone instr_succ in
        Llvm.insert_into_builder instr_succ_clone ""
          (Llvm.builder_before llctx instr);
        Llvm.replace_all_uses_with instr_succ instr_succ_clone;
        Llvm.delete_instruction instr_succ;
        instr_succ_clone

(** [make_conditional llctx instr] substitutes
    an unconditional branch instruction [instr]
    into always-true conditional branch instruction.
    (Block instructions are cloned between both destinations, except names.)
    Returns the conditional branch instruction. *)
let make_conditional llctx instr =
  match instr |> Llvm.get_branch |> Option.get with
  | `Unconditional target_block ->
      let block = Llvm.instr_parent instr in
      let fbb = Llvm.append_block llctx "" (Llvm.block_parent block) in
      Llvm.move_block_after target_block fbb;
      Llvm.iter_instrs
        (fun i ->
          Llvm.insert_into_builder (Llvm.instr_clone i) ""
            (Llvm.builder_at_end llctx fbb))
        target_block;
      Llvm.delete_instruction instr;
      Llvm.build_cond_br
        (Llvm.const_int (Llvm.i1_type llctx) 1)
        target_block fbb
        (Llvm.builder_at_end llctx block)
  | `Conditional _ -> failwith "Conditional branch already"

(** [make_unconditional llctx instr] substitutes
    a conditional branch instruction [instr]
    into unconditional branch instruction targets for true-branch.
    (False branch block remains in the module; just not used by the branch.)
    Returns the unconditional branch instruction. *)
let make_unconditional llctx instr =
  match instr |> Llvm.get_branch |> Option.get with
  | `Conditional (_, tbb, _) ->
      let block = Llvm.instr_parent instr in
      Llvm.delete_instruction instr;
      Llvm.build_br tbb (Llvm.builder_at_end llctx block)
  | `Unconditional _ -> failwith "Unconditional branch already"

(** [set_unconditional_dest llctx instr bb] sets
    the destinations of the unconditional branch instruction [instr] to [bb].
    Returns the new instruction. *)
let set_unconditional_dest llctx instr bb =
  match instr |> Llvm.get_branch |> Option.get with
  | `Unconditional _ ->
      let result = Llvm.build_br bb (Llvm.builder_before llctx instr) in
      Llvm.delete_instruction instr;
      result
  | `Conditional _ -> failwith "Conditional branch"

(** [set_conditional_dest llctx instr tbb fbb] sets
    the destinations of the conditional branch instruction [instr].
    If given as [None], retains the original destination.
    Returns the new instruction. *)
let set_conditional_dest llctx instr tbb fbb =
  match instr |> Llvm.get_branch |> Option.get with
  | `Conditional (cond, old_tbb, old_fbb) ->
      let result =
        Llvm.build_cond_br cond
          (match tbb with Some tbb -> tbb | None -> old_tbb)
          (match fbb with Some fbb -> fbb | None -> old_fbb)
          (Llvm.builder_before llctx instr)
      in
      Llvm.delete_instruction instr;
      result
  | `Unconditional _ -> failwith "Unconditional branch"

(** [split_block llctx loc] splits the parent block of [loc] into two blocks
    and links them by unconditional branch.
    [loc] becomes the first instruction of the latter block.
    Returns the former block. *)
let split_block llctx loc =
  let block = Llvm.instr_parent loc in
  let new_block = Llvm.insert_block llctx "" block in
  let builder = Llvm.builder_at_end llctx new_block in

  (* initial setting *)
  let dummy = Llvm.build_unreachable builder in
  Llvm.position_before dummy builder;

  (* migrating instructions *)
  let rec aux () =
    match Llvm.instr_begin block with
    | Before i when i = loc -> ()
    | Before i ->
        let i_clone = Llvm.instr_clone i in
        Llvm.insert_into_builder i_clone "" builder;
        Llvm.replace_all_uses_with i i_clone;
        Llvm.delete_instruction i;
        aux ()
    | Llvm.At_end _ -> failwith "NEVER OCCUR"
  in
  aux ();

  (* modifying all branches targets original block *)
  Llvm.iter_blocks
    (fun b ->
      let ter = b |> Llvm.block_terminator |> Option.get in
      let succs = ter |> Llvm.successors in
      Array.iteri
        (fun i elem -> if elem = block then Llvm.set_successor ter i new_block)
        succs)
    (loc |> Llvm.instr_parent |> Llvm.block_parent);

  (* linking and cleaning *)
  Llvm.build_br block builder |> ignore;
  Llvm.delete_instruction dummy;

  (* finally done *)
  new_block

(** [modify_value llctx v l] slightly modifies value [v]
    or returns a random element of [l]. *)
let modify_value _ v l =
  let ty = Llvm.type_of v in
  match Llvm.classify_type ty with
  | Llvm.TypeKind.Integer ->
      let c =
        match Llvm.int64_of_const v with
        | Some c -> (
            match Random.int 3 with
            | 0 -> Int64.to_int c * 2
            | 1 -> Int64.to_int c * -1
            | _ -> Int64.to_int c + 1)
        | None -> Random.int 100 - 50
      in
      if l <> [] then
        Utils.list_random [ Llvm.const_int ty c; Utils.list_random l ]
      else Llvm.const_int ty c
  | Llvm.TypeKind.Pointer ->
      (* nothing can be done *)
      if l <> [] then Utils.list_random [ v; Utils.list_random l ] else v
  | _ -> failwith "Not implemented"

(** [create_random_instr llctx loc] creates
    a random instruction before instruction [loc],
    with lists of available arguments declared prior to [loc].
    Returns the new instruction.
    If rejected, returns [loc] instead. *)
let create_random_instr llctx loc =
  let i32 = Llvm.i32_type llctx in
  let ptr = Llvm.pointer_type i32 in
  let zero = Llvm.const_int i32 0 in
  let null = Llvm.const_pointer_null ptr in
  let preds = Utils.get_instrs_before ~wide:true loc in
  let preds_i32 = Utils.list_filter_type i32 preds in
  let preds_ptr = Utils.list_filter_type ptr preds in
  let opcode = OpCls.random_opcode_except None in
  match OpCls.classify opcode with
  | OpCls.TER -> loc (* respect the sole terminator *)
  | ARITH ->
      create_arith_instr llctx loc opcode
        (modify_value llctx zero preds_i32)
        (modify_value llctx zero preds_i32)
  | LOGIC ->
      create_logic_instr llctx loc opcode
        (modify_value llctx zero preds_i32)
        (modify_value llctx zero preds_i32)
  | MEM -> (
      match opcode with
      | Alloca -> create_alloca_instr llctx loc
      | Load -> create_load_instr llctx loc (modify_value llctx null preds_ptr)
      | Store ->
          create_store_instr llctx loc
            (modify_value llctx zero preds_i32)
            (modify_value llctx null preds_ptr)
      | _ -> failwith "NEVER OCCUR")
  | CAST ->
      (* TODO: each cast instruction claims certain type size relation *)
      create_cast_instr llctx loc opcode
        (modify_value llctx zero preds_i32)
        (Llvm.i32_type llctx)
  | CMP ->
      create_cmp_instr llctx loc
        (Utils.list_random OpCls.cmp_kind)
        (modify_value llctx zero preds_i32)
        (modify_value llctx zero preds_i32)
  | PHI ->
      let block = Llvm.instr_parent loc in
      let incoming =
        let rec aux accu rev_pos =
          match rev_pos with
          | Llvm.At_start _ -> accu
          | After b ->
              let ter = b |> Llvm.block_terminator |> Option.get in
              aux
                (if ter |> Llvm.successors |> Array.mem block then
                 let vl =
                   ter
                   |> Utils.get_instrs_before ~wide:false
                   |> Utils.list_filter_type i32
                 in
                 if vl <> [] then (Utils.list_random vl, b) :: accu else accu
                else accu)
                (Llvm.block_pred b)
        in
        aux [] (Llvm.block_pred block)
      in
      if incoming <> [] then create_phi_instr llctx block incoming else loc
  | OTHER -> failwith "Not implemented"

(** [subst_random_instr llctx instr] substitutes
    the instruction [instr] into another random instruction in its class,
    with the same operands.
    Returns the new instruction. *)
let subst_random_instr llctx instr =
  let old_opcode = Llvm.instr_opcode instr in
  let new_opcode = OpCls.random_opcode_except (Some old_opcode) in
  match OpCls.classify new_opcode with
  | OpCls.TER ->
      (* cannot substitute to others *)
      if old_opcode = Llvm.Opcode.Ret then instr
      else if Llvm.is_conditional instr then make_unconditional llctx instr
      else make_conditional llctx instr
  | ARITH -> subst_arith_instr llctx instr new_opcode
  | LOGIC -> subst_logic_instr llctx instr new_opcode
  | MEM -> instr (* cannot substitute to others *)
  | CAST -> instr (* TODO *)
  | CMP ->
      let old_cmp = instr |> Llvm.icmp_predicate |> Option.get in
      let rec aux () =
        let cmp = Utils.list_random OpCls.cmp_kind in
        if cmp = old_cmp then aux () else subst_cmp_instr llctx instr cmp
      in
      aux ()
  | PHI -> instr (* TODO *)
  | OTHER -> failwith "Not implemented"

(** [subst_random_operand instr] substitutes
    a random operand of instruction [instr] into another available one.
    Returns [instr] (with its operand changed).
    If there is no operand, returns [instr] without changes. *)
let subst_random_operand llctx instr =
  let num_operands = Llvm.num_operands instr in
  if num_operands > 0 then (
    let i = Random.int num_operands in
    let old_o = Llvm.operand instr i in
    let candidates =
      Utils.list_filter_type (Llvm.type_of old_o)
        (Utils.get_instrs_before ~wide:true instr)
    in
    if candidates <> [] then
      Llvm.set_operand instr i (modify_value llctx old_o candidates);
    instr)
  else instr

let run llctx llm =
  let open Utils in
  let llm_clone = Llvm_transform_utils.clone_module llm in
  let f = Utils.choose_function llm_clone in
  let all_instrs = Utils.fold_left_all_instr (fun accu i -> i :: accu) [] f in
  let i = Utils.list_random all_instrs in
  let mutate_fun =
    Utils.list_random
      [
        (fun i -> i >> subst_random_operand llctx);
        (fun i -> i >> subst_random_instr llctx);
        (fun i -> i >> create_random_instr llctx);
        (fun i -> i >> split_block llctx);
        (fun i -> i >> lower_instr llctx);
      ]
  in
  mutate_fun i;
  llm_clone
