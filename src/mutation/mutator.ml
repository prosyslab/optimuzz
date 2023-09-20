module LUtil = Util.LUtil
module OpCls = Util.OpHelper.OpcodeClass

(* MID-LEVEL CREATE/SUBSTITUTION HELPERS *)

(* create_[CLASS] llctx loc [args]+ creates corresponding instruction,
   right before instruction [loc], without any extra keywords.
   Returns the new instruction. *)

let create_binary llctx loc opcode o0 o1 =
  (OpCls.build_binary opcode) o0 o1 (Llvm.builder_before llctx loc)

let create_cast llctx loc opcode o ty =
  (OpCls.build_cast opcode) o ty (Llvm.builder_before llctx loc)

let create_cmp llctx loc icmp o0 o1 =
  (OpCls.build_cmp icmp) o0 o1 (Llvm.builder_before llctx loc)

(* subst_[CLASS] llctx instr [args]+ substitutes the instruction [instr]
   into another possible instruction, with the same operands,
   without any extra keywords. Returns the new instruction. *)

let subst_binary llctx instr opcode =
  let nth_opd = Llvm.operand instr in
  let new_instr = create_binary llctx instr opcode (nth_opd 0) (nth_opd 1) in
  LUtil.replace_hard instr new_instr;
  new_instr

let subst_cast _ = failwith "Not implemented"

let subst_cmp llctx instr icmp =
  let nth_opd = Llvm.operand instr in
  let new_instr = create_cmp llctx instr icmp (nth_opd 0) (nth_opd 1) in
  LUtil.replace_hard instr new_instr;
  new_instr

(** [create_phi llctx loc incoming] creates
    a PHI instruction instruction at the beginning of block [loc],
    with [incoming].
    Returns the new instruction. *)
let create_phi llctx loc incoming =
  OpCls.build_phi incoming ""
    (Llvm.builder_before llctx
       (match Llvm.instr_begin loc with
       | Before i -> i
       | At_end _ -> failwith "NEVER OCCUR"))

(* TODO: what is the 'substitution' of phi instruction? *)

(** [create_alloca llctx loc] creates
    an alloca instruction right before instruction [loc].
    Returns the new instruction. *)
let create_alloca llctx instr =
  Llvm.build_alloca (Llvm.i32_type llctx) "" (Llvm.builder_before llctx instr)

(** [create_load llctx loc o] creates
    a load instruction right before instruction [loc], with operand [o].
    Returns the new instruction. *)
let create_load llctx loc o =
  Llvm.build_load o "" (Llvm.builder_before llctx loc)

(** [create_store llctx loc o0 o1] creates
    a store instruction right before instruction [loc],
    with operands [o0] (value) and [o1] (pointer).
    Return the new instruction. *)
let create_store llctx loc o0 o1 =
  Llvm.build_store o0 o1 (Llvm.builder_before llctx loc)

module CFG_Modifier = struct
  (* HIGHER-LEVEL CFG MODIFYING FUNCTIONS *)

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
          LUtil.replace_hard instr_succ instr_succ_clone;
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
          LUtil.replace_hard i i_clone;
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
          (fun i elem ->
            if elem = block then Llvm.set_successor ter i new_block)
          succs)
      (loc |> Llvm.instr_parent |> Llvm.block_parent);

    (* linking and cleaning *)
    Llvm.build_br block builder |> ignore;
    Llvm.delete_instruction dummy;

    (* finally done *)
    new_block
end

(* [randget_operand llctx loc ty] gets, or generates
   a llvalue as an operand, of type [ty], valid at [loc]. *)
let randget_operand loc ty =
  let rand_const =
    Llvm.const_int ty
      (Random.int ((1 lsl min (Util.OpHelper.TypeBW.bw_of_llint ty) 30) - 1))
  in
  rand_const
  :: (loc |> LUtil.get_instrs_before ~wide:false |> LUtil.list_filter_type ty)
  |> LUtil.list_random

(** [create_random_instr llctx loc] creates
    a random instruction before instruction [loc],
    with lists of available arguments declared prior to [loc].
    Returns the new instruction.
    If rejected, returns [loc] instead. *)
let create_random_instr llctx loc =
  let preds = LUtil.get_instrs_before ~wide:false loc in
  let operand =
    if preds <> [] then LUtil.list_random preds
    else randget_operand loc (Llvm.i32_type llctx)
  in
  let operand_ty = Llvm.type_of operand in
  let opcode = OpCls.random_opcode () in
  match OpCls.classify opcode with
  | BINARY ->
      create_binary llctx loc opcode operand (randget_operand loc operand_ty)
  | CAST ->
      let dest_ty =
        match opcode with
        | Trunc -> Util.OpHelper.TypeBW.random_narrower_llint llctx operand_ty
        | ZExt | SExt ->
            Util.OpHelper.TypeBW.random_wider_llint llctx operand_ty
        | _ -> failwith "NEVER OCCUR"
      in
      create_cast llctx loc opcode operand dest_ty
  | CMP ->
      create_cmp llctx loc
        (LUtil.list_random OpCls.cmp_kind)
        operand
        (randget_operand loc operand_ty)
  | TER | MEM | PHI -> loc

(** [subst_random_instr llctx instr] substitutes
    the instruction [instr] into another random instruction in its class,
    with the same operands.
    Returns the new instruction. *)
let subst_random_instr llctx instr =
  let old_opcode = Llvm.instr_opcode instr in
  let new_opcode = OpCls.random_opcode_except old_opcode in
  match OpCls.classify new_opcode with
  | BINARY -> subst_binary llctx instr new_opcode
  | CAST -> instr (* can do nothing *)
  | CMP ->
      let old_cmp = instr |> Llvm.icmp_predicate |> Option.get in
      let rec aux () =
        let cmp = OpCls.random_cmp () in
        if cmp = old_cmp then aux () else subst_cmp llctx instr cmp
      in
      aux ()
  | TER | MEM | PHI -> instr (* TODO *)

(** [subst_random_operand instr] substitutes
    a random operand of instruction [instr] into another available one.
    Returns [instr] (with its operand changed). *)
let subst_random_operand _ instr =
  let num_operands = Llvm.num_operands instr in
  let i = Random.int num_operands in
  let operand_old = Llvm.operand instr i in
  let operand_new = randget_operand instr (Llvm.type_of operand_old) in
  Llvm.set_operand instr i operand_new;
  instr

(* CAUTION: THESE FUNCTIONS DIRECTLY MODIFIES GIVEN LLVM MODULE. *)

(* CFG-related mutation *)
let mutate_CFG _ = Fun.id

(* inner-basicblock mutation (independent of block CFG) *)
let mutate_inner_bb llctx llm =
  let open LUtil in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu i -> i :: accu) [] f in
  let i = list_random all_instrs in
  let mutate_fun =
    list_random
      [
        (fun i -> i >> subst_random_operand llctx);
        (fun i -> i >> subst_random_instr llctx);
        (fun i -> i >> create_random_instr llctx);
      ]
  in
  mutate_fun i;
  llm

(* possible reflection of inner-basicblock mutation to CFG *)
let mutate_transmission _ = Fun.id

let run llctx llm =
  llm |> Llvm_transform_utils.clone_module |> mutate_CFG llctx
  |> mutate_inner_bb llctx |> mutate_transmission llctx
