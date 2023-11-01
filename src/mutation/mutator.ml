module LUtil = Util.LUtil
module OpCls = Util.OpHelper.OpcodeClass

type mode_t = EXPAND | FOCUS

(* CFG PRESERVING MUTATION HELPERS *)

(* create_[CLASS] llctx loc [args]+ creates corresponding instruction,
   right before instruction [loc], without any extra keywords.
   Returns the new instruction. *)

let create_binary llctx loc opcode o0 o1 =
  Some ((OpCls.build_binary opcode) o0 o1 (Llvm.builder_before llctx loc))

let create_cast llctx loc opcode o ty =
  Some ((OpCls.build_cast opcode) o ty (Llvm.builder_before llctx loc))

let create_cmp llctx loc icmp o0 o1 =
  Some ((OpCls.build_cmp icmp) o0 o1 (Llvm.builder_before llctx loc))

(* subst_[CLASS] llctx instr [args]+ substitutes the instruction [instr]
   into another possible instruction, with the same operands,
   without any extra keywords. Returns the new instruction. *)

let subst_binary llctx instr opcode =
  let nth_opd = Llvm.operand instr in
  let new_instr =
    create_binary llctx instr opcode (nth_opd 0) (nth_opd 1) |> Option.get
  in
  LUtil.replace_and_ret instr new_instr

let subst_cast llctx instr =
  (* ZExt -> SExt, SExt -> ZExt, Trunc -> Trunc *)
  match Llvm.instr_opcode instr with
  | ZExt ->
      let new_instr =
        create_cast llctx instr Llvm.Opcode.SExt (Llvm.operand instr 0)
          (Llvm.type_of instr)
        |> Option.get
      in
      LUtil.replace_and_ret instr new_instr
  | SExt ->
      let new_instr =
        create_cast llctx instr Llvm.Opcode.ZExt (Llvm.operand instr 0)
          (Llvm.type_of instr)
        |> Option.get
      in
      LUtil.replace_and_ret instr new_instr
  | Trunc -> None
  | _ -> raise Util.OpHelper.Improper_class

let subst_cmp llctx instr icmp =
  let nth_opd = Llvm.operand instr in
  let new_instr =
    create_cmp llctx instr icmp (nth_opd 0) (nth_opd 1) |> Option.get
  in
  LUtil.replace_and_ret instr new_instr

(* CFG MODIFYING MUTATION HELPERS *)

module CFG_Modifier = struct
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

(* HIGH-LEVEL MUTATION HELPERS *)

(** [randget_operand llctx loc ty] gets, or generates
   a llvalue as an operand, of type [ty], valid at [loc], if possible.
   NOTE: if [ty] is an integer type, this will always return Some(_). *)
let randget_operand loc ty =
  let candidates =
    loc |> LUtil.get_instrs_before ~wide:false |> LUtil.list_filter_type ty
  in
  let candidates =
    if Llvm.classify_type ty = Llvm.TypeKind.Integer then
      Llvm.const_int ty
        (Random.int ((1 lsl min (Util.OpHelper.TypeBW.bw_of_llint ty) 30) - 1))
      :: candidates
    else candidates
  in
  if candidates <> [] then Some (LUtil.list_random candidates) else None

(** [create_rand_instr llctx preferred_opd loc] creates
    a random instruction before instruction [loc],
    with lists of available arguments declared prior to [loc]. *)
let rec create_rand_instr llctx preferred_opd loc =
  let preds = LUtil.get_instrs_before ~wide:false loc in

  (* will create integer type instruction only *)
  let preds =
    List.filter
      (fun llv ->
        llv |> Llvm.type_of |> Llvm.classify_type = Llvm.TypeKind.Integer)
      preds
  in

  let operand =
    match preferred_opd with
    | Some pref_opd
      when pref_opd |> Llvm.type_of |> Llvm.classify_type = Integer ->
        pref_opd
    | _ ->
        if preds <> [] then LUtil.list_random preds
        else randget_operand loc (Llvm.i32_type llctx) |> Option.get
  in
  let operand_ty = Llvm.type_of operand in

  let opcode = OpCls.random_opcode () in
  match OpCls.classify opcode with
  | BINARY ->
      create_binary llctx loc opcode operand
        (randget_operand loc operand_ty |> Option.get)
  | CAST -> (
      try
        let dest_ty =
          match opcode with
          | Trunc -> Util.OpHelper.TypeBW.random_narrower_llint llctx operand_ty
          | ZExt | SExt ->
              Util.OpHelper.TypeBW.random_wider_llint llctx operand_ty
          | _ -> failwith "NEVER OCCUR"
        in
        create_cast llctx loc opcode operand dest_ty
      with Util.OpHelper.Unsupported ->
        create_rand_instr llctx preferred_opd loc)
  | CMP ->
      create_cmp llctx loc
        (LUtil.list_random OpCls.cmp_kind)
        operand
        (randget_operand loc operand_ty |> Option.get)
  | _ ->
      (* choose another instruction *)
      create_rand_instr llctx preferred_opd loc

(** [subst_rand_instr llctx instr] substitutes
    the instruction [instr] into another random instruction in its class,
    with the same operands. *)
let subst_rand_instr llctx instr =
  let old_opcode = Llvm.instr_opcode instr in
  match OpCls.classify old_opcode with
  | BINARY ->
      let new_opcode = OpCls.random_opcode_except old_opcode in
      subst_binary llctx instr new_opcode
  | CAST -> subst_cast llctx instr
  | CMP ->
      let old_cmp = instr |> Llvm.icmp_predicate |> Option.get in
      let rec aux () =
        let cmp = OpCls.random_cmp () in
        if cmp = old_cmp then aux () else subst_cmp llctx instr cmp
      in
      aux ()
  | _ -> None

(** [subst_random_operand llctx preferred_opd instr] substitutes
    a random operand of instruction [instr]
    into another available random one. *)
let rec subst_rand_opd llctx preferred_opd instr =
  let num_operands = Llvm.num_operands instr in
  let opd_i = Llvm.operand instr in

  match preferred_opd with
  | Some preferred_opd -> (
      let preferred_ty = Llvm.type_of preferred_opd in
      let check_ty llv = llv |> Llvm.type_of |> ( = ) preferred_ty in
      match instr |> Llvm.instr_opcode |> OpCls.classify with
      | (BINARY | CAST | CMP) when num_operands > 0 -> (
          match num_operands with
          | 1 ->
              let operand_old = opd_i 0 in
              if check_ty operand_old then
                LUtil.set_opd_and_ret instr 0 preferred_opd
              else subst_rand_opd llctx None instr
          | 2 -> (
              (* try best to use the preferred operand *)
              match (check_ty (opd_i 0), check_ty (opd_i 1)) with
              | false, false ->
                  (* cannot use the preferred operand *)
                  subst_rand_opd llctx None instr
              | false, true -> LUtil.set_opd_and_ret instr 1 preferred_opd
              | true, false -> LUtil.set_opd_and_ret instr 0 preferred_opd
              | true, true ->
                  (* both are ok; replace random one into the preferred one *)
                  let i = Random.int 2 in
                  LUtil.set_opd_and_ret instr i preferred_opd)
          | _ -> None)
      | _ -> None)
  | None ->
      if num_operands > 0 then
        let i = Random.int num_operands in
        let operand_old = opd_i i in
        match randget_operand instr (Llvm.type_of operand_old) with
        | Some operand_new -> LUtil.set_opd_and_ret instr i operand_new
        | None -> None
      else None

(** [modify_flag llctx instr] tries to grant or retrieve
    a random flag to the instruction [instr].
    Returns [instr], with or without change. *)
let modify_flag llctx instr =
  let opcode = Llvm.instr_opcode instr in
  match OpCls.classify opcode with
  | BINARY -> (
      let flagger =
        LUtil.list_random
          [
            OpCls.build_nsw_binary;
            OpCls.build_nuw_binary;
            OpCls.build_exact_binary;
          ]
      in
      try
        let new_instr =
          flagger opcode (Llvm.operand instr 0) (Llvm.operand instr 1)
            (Llvm.builder_before llctx instr)
        in
        LUtil.replace_and_ret instr new_instr
      with Util.OpHelper.Unsupported -> None)
  | _ -> None

(** [make_chain llctx len instr initial_opd] make chained mutation;
    For example, if the original llvm was ... -> instr -> i1 -> ...,
    calling this will make: ... -> (chain of length [len]) -> instr -> i1,
    where an operand of instr will be replaced of the last mutation of chain.
    Returns operand-substitued [instr]. *)
let make_chain llctx len first_opd instr =
  assert (len >= 2);
  let create pref = create_rand_instr llctx pref instr in
  let rec aux i accu =
    if i = 1 then accu else aux (i - 1) (Some (create accu |> Option.get))
  in
  subst_rand_opd llctx (aux len first_opd) instr

(* ACTUAL MUTATION FUNCTIONS *)
(* CAUTION: THESE FUNCTIONS DIRECTLY MODIFIES GIVEN LLVM MODULE. *)

(* CFG-related mutation *)
let mutate_CFG = Fun.id

(* inner-basicblock mutation (independent of block CFG) *)
let rec mutate_inner_bb llctx mode times llm =
  if times = 0 then llm
  else if times < 0 then
    raise (invalid_arg "mutation must be made by nonnegative num of times")
  else
    let open LUtil in
    (* find function and target location *)
    let f = choose_function llm in
    let all_instrs =
      fold_left_all_instr (fun accu instr -> instr :: accu) [] f
    in
    let instr_tgt = list_random all_instrs in

    (* valid mutations; delay actual action using closure *)
    let mutation_list =
      [
        (1, subst_rand_instr llctx);
        (1, subst_rand_opd llctx None);
        (1, modify_flag llctx);
      ]
    in

    (* depending on mode, available mutations differ *)
    let mutation_list =
      if mode = EXPAND then
        let mutation_list =
          (1, create_rand_instr llctx None) :: mutation_list
        in
        let rec aux i accu =
          if i > times then accu
          else aux (i + 1) ((i, make_chain llctx i None) :: accu)
        in
        aux 2 mutation_list
      else mutation_list
    in

    (* mutate and recurse *)
    let times_used, mutation = list_random mutation_list in
    match mutation instr_tgt with
    | Some _ -> mutate_inner_bb llctx mode (times - times_used) llm
    | None -> mutate_inner_bb llctx mode times llm

(* TODO: add fuzzing configuration *)
let run llctx mode times llm =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  mutate_inner_bb llctx mode times llm_clone |> mutate_CFG
