open Util.ALlvm
module AUtil = Util.AUtil
module OpCls = OpcodeClass

type mode_t = EXPAND | FOCUS
type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE

(* choose mutation *)
let choose_mutation mode distance =
  match mode with
  | EXPAND ->
      let mutation_list = [ CREATE; OPCODE; OPERAND; FLAG; TYPE ] in
      let random_int = Random.int (distance + List.length mutation_list) in
      if random_int <= distance then List.nth mutation_list 0
      else List.nth mutation_list (random_int - distance)
  | FOCUS ->
      let mutation_list = [ OPCODE; OPERAND; FLAG; TYPE ] in
      List.nth mutation_list (Random.int (List.length mutation_list))

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
      const_int ty (AUtil.list_random AUtil.interesting_integers) :: candidates
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

let is_there_hard_op f =
  fold_left_all_instr
    (fun accu i ->
      accu
      ||
      match i |> instr_opcode |> OpCls.classify with
      | MEM | PHI | OTHER -> true
      | _ -> false)
    false f

let is_ret_nonsingle f =
  fold_left_all_instr
    (fun accu i -> if instr_opcode i = Ret then accu + 1 else accu)
    0 f
  <> 1

let is_mistargeting llv =
  match classify_value llv with
  | Instruction opc -> (
      match OpCls.classify opc with BINARY | CAST -> false | _ -> true)
  | _ -> false

let rec clean f =
  let aux instr =
    if Option.is_none (use_begin instr) && instr_opcode instr <> Ret then (
      delete_instruction instr;
      true)
    else false
  in
  if fold_left_all_instr (fun accu i -> accu || aux i) false f then clean f
  else ()

let rec choose_random_type llctx =
  let random_int = Random.int 129 in
  if random_int = 0 then choose_random_type llctx
  else integer_type llctx random_int

let rec do_change_type llctx ty_new f llv =
  let ty_old = type_of llv in
  let bw_old = integer_bitwidth ty_old in
  let bw_new = integer_bitwidth ty_new in

  (* expect parameter or instruction only *)
  assert (llv |> is_constant |> not);

  (* two types might be same *)
  let llv' =
    if bw_old <> bw_new then (
      (* create type cast right after definition *)
      let insert_point =
        match classify_value llv with
        | Argument -> f |> entry_block |> instr_begin
        | Instruction _ -> instr_succ llv
        | _ -> failwith "Allowing parameter or instruction only"
      in
      let llb = builder_at llctx insert_point in
      (* FIXME: ONLY USING ZEXT *)
      let build = if bw_old < bw_new then build_zext else build_trunc in
      let llv' = build llv ty_new "" llb in
      replace_all_uses_with llv llv';
      set_operand llv' 0 llv;
      llv')
    else llv
  in

  (* propagate over all related llvalues *)
  let propagate u =
    let instr = user u in
    let cls = instr |> instr_opcode |> OpCls.classify in
    match cls with
    | TER ->
        (* TER with operand => return *)
        let ret_ty = f |> type_of |> return_type |> return_type in
        let bw_ret = integer_bitwidth ret_ty in
        if bw_ret < bw_new then
          let foo =
            build_trunc (used_value u) ret_ty "" (builder_before llctx instr)
          in
          set_operand instr 0 foo
        else if bw_ret > bw_new then
          (* FIXME: USING ZEXT ONLY *)
          let foo =
            build_zext (used_value u) ret_ty "" (builder_before llctx instr)
          in
          set_operand instr 0 foo
        else ()
    | BINARY | CMP ->
        (* find additional llvalues to change type *)
        let idx = if operand instr 0 = llv' then 1 else 0 in
        let opd_tgt = operand instr idx in
        if is_constant opd_tgt then
          (* FIXME: USING ZEXT ONLY *)
          let const_edit =
            if bw_old < bw_new then const_zext else const_trunc
          in
          set_operand instr idx (const_edit opd_tgt ty_new)
        else if opd_tgt |> type_of |> integer_bitwidth <> bw_new then
          do_change_type llctx ty_new f opd_tgt;

        if cls = BINARY then (
          (* the instruction itself should change its type;
             i34 + i34 still remains i32 if we use `set_operand`.
             MUST NOT delete this instruction immediately *)
          let instr' = instr_clone instr in
          insert_into_builder instr' "" (builder_before llctx instr);
          replace_all_uses_with instr instr';

          (* just triggering propagation *)
          do_change_type llctx ty_new f instr')
    | CAST ->
        ( (* FIXME: type change of operand might affect cast operation *) )
    | _ -> failwith "NEVER OCCUR"
  in
  iter_uses propagate llv'

(** [change_type llctx ty_new llv] changes type of [llv] to [ty_new].
    All the other associated values are recursively changed.
    Returns [Some(instr)] if success, or [None] else. *)
let change_type llctx ty_new llv =
  let f =
    match classify_value llv with
    | Argument -> param_parent llv
    | Instruction _ -> llv |> instr_parent |> block_parent
    | _ -> failwith "Allowing parameter or instruction only"
  in

  (* regard this attempt unfeasible if... *)
  if
    (not (TypeBW.is_llint (type_of llv) && TypeBW.is_llint ty_new))
    || is_there_hard_op f || is_ret_nonsingle f || is_mistargeting llv
  then None
  else (
    (* actual type change *)
    do_change_type llctx ty_new f llv;
    clean f;
    Some llv)

(* ACTUAL MUTATION FUNCTIONS *)
(* CAUTION: THESE FUNCTIONS DIRECTLY MODIFIES GIVEN LLVM MODULE. *)

(* CFG-related mutation *)
let mutate_CFG = Fun.id

(* inner-basicblock mutation (independent of block CFG) *)
let rec mutate_inner_bb llctx mode times llm distance =
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
    (* depending on mode, available mutations differ *)
    let mutation = choose_mutation mode distance in
    (* mutate and recurse *)
    let mutation_result =
      match mutation with
      | CREATE -> make_chain llctx 2 None instr_tgt
      | OPCODE -> subst_rand_instr llctx instr_tgt
      | OPERAND -> subst_rand_opd llctx None instr_tgt
      | FLAG -> modify_flag llctx instr_tgt
      | TYPE -> change_type llctx (choose_random_type llctx) instr_tgt
    in
    match mutation_result with
    | Some _ -> mutate_inner_bb llctx mode (times - 1) llm distance
    | None -> mutate_inner_bb llctx mode times llm distance

(* TODO: add fuzzing configuration *)
let run llctx mode times llm distance =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  mutate_inner_bb llctx mode times llm_clone distance |> mutate_CFG
