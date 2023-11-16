open Util.ALlvm
module AUtil = Util.AUtil
module OpCls = OpcodeClass

type mode_t = EXPAND | FOCUS

(* CFG PRESERVING MUTATION HELPERS *)

(* create_[CLASS] llctx loc [args]+ creates corresponding instruction,
   right before instruction [loc], without any extra keywords.
   Returns the new instruction. *)

let create_binary llctx loc opcode o0 o1 =
  Some ((OpCls.build_binary opcode) o0 o1 (builder_before llctx loc))

let create_cast llctx loc opcode o ty =
  Some ((OpCls.build_cast opcode) o ty (builder_before llctx loc))

let create_cmp llctx loc icmp o0 o1 =
  Some ((OpCls.build_cmp icmp) o0 o1 (builder_before llctx loc))

(* subst_[CLASS] llctx instr [args]+ substitutes the instruction [instr]
   into another possible instruction, with the same operands,
   without any extra keywords. Returns the new instruction. *)

let subst_binary llctx instr opcode =
  let nth_opd = operand instr in
  let new_instr =
    create_binary llctx instr opcode (nth_opd 0) (nth_opd 1) |> Option.get
  in
  replace_and_ret instr new_instr

let subst_cast llctx instr =
  (* ZExt -> SExt, SExt -> ZExt, Trunc -> Trunc *)
  match instr_opcode instr with
  | ZExt ->
      let new_instr =
        create_cast llctx instr Opcode.SExt (operand instr 0) (type_of instr)
        |> Option.get
      in
      replace_and_ret instr new_instr
  | SExt ->
      let new_instr =
        create_cast llctx instr Opcode.ZExt (operand instr 0) (type_of instr)
        |> Option.get
      in
      replace_and_ret instr new_instr
  | Trunc -> None
  | _ -> raise OpCls.Improper_class

let subst_cmp llctx instr icmp =
  let nth_opd = operand instr in
  let new_instr =
    create_cmp llctx instr icmp (nth_opd 0) (nth_opd 1) |> Option.get
  in
  replace_and_ret instr new_instr

(* CFG MODIFYING MUTATION HELPERS *)

module CFG_Modifier = struct
  (** [make_conditional llctx instr] substitutes
    an unconditional branch instruction [instr]
    into always-true conditional branch instruction.
    (Block instructions are cloned between both destinations, except names.)
    Returns the conditional branch instruction. *)
  let make_conditional llctx instr =
    match instr |> get_branch |> Option.get with
    | `Unconditional target_block ->
        let block = instr_parent instr in
        let fbb = append_block llctx "" (block_parent block) in
        move_block_after target_block fbb;
        iter_instrs
          (fun i ->
            insert_into_builder (instr_clone i) "" (builder_at_end llctx fbb))
          target_block;
        delete_instruction instr;
        build_cond_br
          (const_int (i1_type llctx) 1)
          target_block fbb
          (builder_at_end llctx block)
    | `Conditional _ -> failwith "Conditional branch already"

  (** [make_unconditional llctx instr] substitutes
    a conditional branch instruction [instr]
    into unconditional branch instruction targets for true-branch.
    (False branch block remains in the module; just not used by the branch.)
    Returns the unconditional branch instruction. *)
  let make_unconditional llctx instr =
    match instr |> get_branch |> Option.get with
    | `Conditional (_, tbb, _) ->
        let block = instr_parent instr in
        delete_instruction instr;
        build_br tbb (builder_at_end llctx block)
    | `Unconditional _ -> failwith "Unconditional branch already"

  (** [set_unconditional_dest llctx instr bb] sets
    the destinations of the unconditional branch instruction [instr] to [bb].
    Returns the new instruction. *)
  let set_unconditional_dest llctx instr bb =
    match instr |> get_branch |> Option.get with
    | `Unconditional _ ->
        let result = build_br bb (builder_before llctx instr) in
        delete_instruction instr;
        result
    | `Conditional _ -> failwith "Conditional branch"

  (** [set_conditional_dest llctx instr tbb fbb] sets
    the destinations of the conditional branch instruction [instr].
    If given as [None], retains the original destination.
    Returns the new instruction. *)
  let set_conditional_dest llctx instr tbb fbb =
    match instr |> get_branch |> Option.get with
    | `Conditional (cond, old_tbb, old_fbb) ->
        let result =
          build_cond_br cond
            (match tbb with Some tbb -> tbb | None -> old_tbb)
            (match fbb with Some fbb -> fbb | None -> old_fbb)
            (builder_before llctx instr)
        in
        delete_instruction instr;
        result
    | `Unconditional _ -> failwith "Unconditional branch"

  (** [split_block llctx loc] splits the parent block of [loc] into two blocks
    and links them by unconditional branch.
    [loc] becomes the first instruction of the latter block.
    Returns the former block. *)
  let split_block llctx loc =
    let block = instr_parent loc in
    let new_block = insert_block llctx "" block in
    let builder = builder_at_end llctx new_block in

    (* initial setting *)
    let dummy = build_unreachable builder in
    position_before dummy builder;

    (* migrating instructions *)
    let rec aux () =
      match instr_begin block with
      | Before i when i = loc -> ()
      | Before i ->
          let i_clone = instr_clone i in
          insert_into_builder i_clone "" builder;
          replace_hard i i_clone;
          aux ()
      | At_end _ -> failwith "NEVER OCCUR"
    in
    aux ();

    (* modifying all branches targets original block *)
    iter_blocks
      (fun b ->
        let ter = b |> block_terminator |> Option.get in
        let succs = ter |> successors in
        Array.iteri
          (fun i elem -> if elem = block then set_successor ter i new_block)
          succs)
      (loc |> instr_parent |> block_parent);

    (* linking and cleaning *)
    build_br block builder |> ignore;
    delete_instruction dummy;

    (* finally done *)
    new_block
end

(* HIGH-LEVEL MUTATION HELPERS *)

(** [randget_operand llctx loc ty] gets, or generates
   a llvalue as an operand, of type [ty], valid at [loc], if possible.
   NOTE: if [ty] is an integer type, this will always return Some(_). *)
let randget_operand loc ty =
  let candidates =
    loc |> get_instrs_before ~wide:false |> list_filter_type ty
  in
  let candidates =
    if classify_type ty = TypeKind.Integer then
      const_int ty (Random.int ((1 lsl min (TypeBW.bw_of_llint ty) 30) - 1))
      :: candidates
    else candidates
  in
  if candidates <> [] then Some (AUtil.list_random candidates) else None

(** [create_rand_instr llctx preferred_opd loc] creates
    a random instruction before instruction [loc],
    with lists of available arguments declared prior to [loc]. *)
let rec create_rand_instr llctx preferred_opd loc =
  let preds = get_instrs_before ~wide:false loc in

  (* will create integer type instruction only *)
  let preds =
    List.filter
      (fun llv -> llv |> type_of |> classify_type = TypeKind.Integer)
      preds
  in

  let operand =
    match preferred_opd with
    | Some pref_opd when pref_opd |> type_of |> classify_type = Integer ->
        pref_opd
    | _ ->
        if preds <> [] then AUtil.list_random preds
        else randget_operand loc (i32_type llctx) |> Option.get
  in
  let operand_ty = type_of operand in

  let opcode = OpCls.random_opcode () in
  match OpCls.classify opcode with
  | BINARY ->
      create_binary llctx loc opcode operand
        (randget_operand loc operand_ty |> Option.get)
  | CAST -> (
      try
        let dest_ty =
          match opcode with
          | Trunc -> TypeBW.random_narrower_llint llctx operand_ty
          | ZExt | SExt -> TypeBW.random_wider_llint llctx operand_ty
          | _ -> failwith "NEVER OCCUR"
        in
        create_cast llctx loc opcode operand dest_ty
      with TypeBW.Unsupported_Type ->
        create_rand_instr llctx preferred_opd loc)
  | CMP ->
      create_cmp llctx loc
        (AUtil.list_random OpCls.cmp_kind)
        operand
        (randget_operand loc operand_ty |> Option.get)
  | _ ->
      (* choose another instruction *)
      create_rand_instr llctx preferred_opd loc

(** [subst_rand_instr llctx instr] substitutes
    the instruction [instr] into another random instruction in its class,
    with the same operands. *)
let subst_rand_instr llctx instr =
  let old_opcode = instr_opcode instr in
  match OpCls.classify old_opcode with
  | BINARY ->
      let new_opcode = OpCls.random_opcode_except old_opcode in
      subst_binary llctx instr new_opcode
  | CAST -> subst_cast llctx instr
  | CMP ->
      let old_cmp = instr |> icmp_predicate |> Option.get in
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
  let num_operands = num_operands instr in
  let opd_i = operand instr in

  match preferred_opd with
  | Some preferred_opd -> (
      let preferred_ty = type_of preferred_opd in
      let check_ty llv = llv |> type_of |> ( = ) preferred_ty in
      match instr |> instr_opcode |> OpCls.classify with
      | (BINARY | CAST | CMP) when num_operands > 0 -> (
          match num_operands with
          | 1 ->
              let operand_old = opd_i 0 in
              if check_ty operand_old then set_opd_and_ret instr 0 preferred_opd
              else subst_rand_opd llctx None instr
          | 2 -> (
              (* try best to use the preferred operand *)
              match (check_ty (opd_i 0), check_ty (opd_i 1)) with
              | false, false ->
                  (* cannot use the preferred operand *)
                  subst_rand_opd llctx None instr
              | false, true -> set_opd_and_ret instr 1 preferred_opd
              | true, false -> set_opd_and_ret instr 0 preferred_opd
              | true, true ->
                  (* both are ok; replace random one into the preferred one *)
                  let i = Random.int 2 in
                  set_opd_and_ret instr i preferred_opd)
          | _ -> None)
      | _ -> None)
  | None ->
      if num_operands > 0 then
        let i = Random.int num_operands in
        let operand_old = opd_i i in
        match randget_operand instr (type_of operand_old) with
        | Some operand_new -> set_opd_and_ret instr i operand_new
        | None -> None
      else None

(** [modify_flag llctx instr] tries to grant or retrieve
    a random flag to the instruction [instr].
    Returns [instr], with or without change. *)
let modify_flag _ instr =
  let open Flag in
  let opcode = instr_opcode instr in
  match OpCls.classify opcode with
  | BINARY ->
      (* there is no instruction that can have both exact and nuw/nsw *)
      if can_overflow opcode then (
        (* can have both nuw and nsw *)
        let nuw_old = is_nuw instr in
        let nsw_old = is_nsw instr in
        let cases =
          match (nuw_old, nsw_old) with
          | false, false -> [ (false, true); (true, false); (true, true) ]
          | false, true -> [ (false, false); (true, false); (true, true) ]
          | true, false -> [ (false, false); (false, true); (true, true) ]
          | true, true -> [ (false, false); (false, true); (true, false) ]
        in
        let nuw_new, nsw_new = AUtil.list_random cases in
        set_nuw nuw_new instr;
        set_nsw nsw_new instr;
        Some instr)
      else if can_be_exact opcode then (
        set_exact (not (is_exact instr)) instr;
        Some instr)
      else None
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
    (* find function and target location *)
    let f = choose_function llm in
    let all_instrs =
      fold_left_all_instr (fun accu instr -> instr :: accu) [] f
    in
    let instr_tgt = AUtil.list_random all_instrs in

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
    let times_used, mutation = AUtil.list_random mutation_list in
    match mutation instr_tgt with
    | Some _ -> mutate_inner_bb llctx mode (times - times_used) llm
    | None -> mutate_inner_bb llctx mode times llm

(* TODO: add fuzzing configuration *)
let run llctx mode times llm =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  mutate_inner_bb llctx mode times llm_clone |> mutate_CFG
