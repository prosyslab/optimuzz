open Util.ALlvm
module AUtil = Util.AUtil
module OpCls = OpcodeClass
module L = Logger

type mode_t = EXPAND | FOCUS
type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE | CUT
type mut = llcontext -> llmodule -> llmodule option (* mutation can fail *)

let pp_mode fmt m =
  match m with
  | EXPAND -> Format.fprintf fmt "EXPAND"
  | FOCUS -> Format.fprintf fmt "FOCUS"

let pp_mutation fmt m =
  match m with
  | CREATE -> Format.fprintf fmt "CREATE"
  | OPCODE -> Format.fprintf fmt "OPCODE"
  | OPERAND -> Format.fprintf fmt "OPERAND"
  | FLAG -> Format.fprintf fmt "FLAG"
  | TYPE -> Format.fprintf fmt "TYPE"
  | CUT -> Format.fprintf fmt "CUT"

let expand_mutations =
  [ (CREATE, 3); (OPCODE, 3); (OPERAND, 3); (FLAG, 3); (TYPE, 2); (CUT, 1) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let focus_mutations =
  [ (OPERAND, 3); (FLAG, 1); (TYPE, 2) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

(* choose mutation *)
let choose_mutation mode score =
  match mode with
  | EXPAND ->
      let mutations = expand_mutations in
      let r = Random.int (score + Array.length mutations) in
      if r <= score then mutations.(0) else mutations.(r - score)
  | FOCUS ->
      let mutations = focus_mutations in
      let r = Random.int (Array.length mutations) in
      mutations.(r)

(* create_[CLASS] llctx loc [args]+ creates corresponding instruction,
   right before instruction [loc], without any extra keywords.
   Returns the new instruction. *)

let create_binary llctx loc opcode o0 o1 =
  (OpCls.build_binary opcode) o0 o1 (builder_before llctx loc)

let create_cast llctx loc opcode o ty =
  (OpCls.build_cast opcode) o ty (builder_before llctx loc)

let create_icmp llctx loc icmp o0 o1 =
  (OpCls.build_icmp icmp) o0 o1 (builder_before llctx loc)

(** [binary_exchange_operands llctx instr] exchanges the two operands of the binary
    instruction [instr], without any extra keywords.
    Returns the new instruction. *)
let binary_exchange_operands llctx instr =
  assert (OpCls.opcls_of instr = BINARY);
  let left = operand instr 0 in
  let right = operand instr 1 in
  let loc = instr in
  let new_instr = create_binary llctx loc (instr_opcode instr) right left in
  replace_hard instr new_instr;
  new_instr

(* subst_[CLASS] llctx instr [args]+ substitutes the instruction [instr]
   into another possible instruction, with the same operands,
   without any extra keywords. Returns the new instruction. *)

let subst_binary llctx instr opcode =
  let left = operand instr 0 in
  let right = operand instr 1 in
  let new_instr = create_binary llctx instr opcode left right in
  replace_hard instr new_instr;
  new_instr

let subst_cast llctx instr =
  assert (OpCls.opcls_of instr = CAST);
  (* ZExt -> SExt, SExt -> ZExt, Trunc -> Trunc (None) *)
  match instr_opcode instr with
  | ZExt ->
      let new_instr =
        create_cast llctx instr Opcode.SExt (operand instr 0) (type_of instr)
      in
      replace_hard instr new_instr;
      Some new_instr
  | SExt ->
      let new_instr =
        create_cast llctx instr Opcode.ZExt (operand instr 0) (type_of instr)
      in
      replace_hard instr new_instr;
      Some new_instr
  | Trunc -> None
  | _ -> failwith "NEVER OCCUR"

let subst_icmp llctx instr cond =
  let left = operand instr 0 in
  let right = operand instr 1 in
  let new_instr = create_icmp llctx instr cond left right in
  replace_hard instr new_instr;
  new_instr

type opd_cands_t = {
  instr : llvalue list;
  param : llvalue list;
  const : llvalue list;
}

let get_rand_const ty =
  let v = AUtil.choose_random !Config.interesting_integers in
  match classify_type ty with
  | Integer -> const_int ty v
  | Vector ->
      const_vector (Array.make (vector_size ty) (const_int (element_type ty) v))
  | Pointer -> const_null ty
  | _ -> failwith ("Unsupported type for get_rand_const: " ^ string_of_lltype ty)

let get_opd_cands loc ty =
  let candidates_instr =
    loc
    |> get_instrs_before ~wide:false
    |> List.filter (fun v -> type_of v = ty)
  in
  let candidates_const =
    match classify_type ty with
    | Integer -> List.map (const_int ty) !Config.interesting_integers
    | Vector ->
        let el_ty = element_type ty in
        let vec_size = vector_size ty in
        let mk_vec i = const_vector (Array.make vec_size (const_int el_ty i)) in
        List.map mk_vec !Config.interesting_integers
    | Pointer -> [ ty |> type_context |> pointer_type |> const_null ]
    | _ -> []
  in
  let candidates_param =
    loc
    |> get_function
    |> fold_left_params
         (fun candidates param ->
           if type_of param = ty then param :: candidates else candidates)
         []
  in
  {
    instr = candidates_instr;
    const = candidates_const;
    param = candidates_param;
  }

let get_opd_cands_nonconst_allty loc =
  let instrs = loc |> get_instrs_before ~wide:false in
  let params = loc |> get_function |> params |> Array.to_list in
  List.rev_append params instrs

(** [get_rand_opd llctx loc instr_old] gets, or generates
    a llvalue as an operand, of type of [instr_old], valid at [loc]. *)
let get_rand_opd loc ty =
  let opd_cands = get_opd_cands loc ty in
  [ opd_cands.instr; opd_cands.param; opd_cands.const ]
  |> List.filter (( <> ) [])
  |> AUtil.choose_random (* at least constant is not empty *)
  |> AUtil.choose_random

(** [get_alternate loc instr_old] find an alternate value for [instr_old],
    valid at [loc].
    If result is equal to [instr_old], this will pick another one.
    Return is wrapped by [Option] to represent impossible cases. *)
let get_alternate loc ?(include_const = false) llv_old =
  let opd_cands = get_opd_cands loc (type_of llv_old) in
  let cands = [ opd_cands.instr; opd_cands.param ] in
  let cands = if include_const then opd_cands.const :: cands else cands in
  let cands_diff =
    cands |> List.map (List.filter (( <> ) llv_old)) |> List.filter (( <> ) [])
  in
  if cands_diff = [] then None
  else Some (cands_diff |> AUtil.choose_random |> AUtil.choose_random)

let get_dst_tys opc ty_src =
  assert (OpCls.classify opc = CAST);
  let tycls_src = classify_type ty_src in
  assert (tycls_src = Integer || tycls_src = Vector);

  let tys_whole =
    if tycls_src = Integer then !Config.interesting_integer_types
    else
      !Config.interesting_vector_types
      |> List.filter (fun t -> vector_size t = vector_size ty_src)
  in
  let bw =
    if tycls_src = Integer then integer_bitwidth
    else fun t -> t |> element_type |> integer_bitwidth
  in
  let pred = if opc = Trunc then ( < ) else ( > ) in
  List.filter (fun t -> pred (bw t) (bw ty_src)) tys_whole

let create_rand_select llctx loc opd =
  let builder = builder_before llctx loc in
  let ty_opd = type_of opd in
  let tycls_opd = classify_type ty_opd in
  assert (tycls_opd = Integer || tycls_opd = Vector);

  (* if opd is i1 or <n x i1>, it can be used as condition *)
  let use_opd_as_cond =
    AUtil.rand_bool ()
    && ((tycls_opd = Integer && integer_bitwidth ty_opd = 1)
       || (tycls_opd = Vector && integer_bitwidth (element_type ty_opd) = 1))
  in

  (* cond, t/f value must have same size (if vector) *)
  let llvs_same_size =
    loc
    |> get_opd_cands_nonconst_allty
    |> List.filter (fun v ->
           let ty_v = type_of v in
           if tycls_opd = Integer then classify_type ty_v = Integer
           else
             classify_type ty_v = Vector
             && vector_size ty_opd = vector_size ty_v)
  in

  let aux cands =
    if cands = [] then get_rand_const ty_opd else AUtil.choose_random cands
  in
  if use_opd_as_cond then
    let () = L.debug "create_rand_select: use the operand as cond" in
    let tv = aux llvs_same_size in
    let fv =
      aux (List.filter (fun v -> type_of v = type_of tv) llvs_same_size)
    in
    build_select opd tv fv "" builder
  else
    let () = L.debug "create_rand_select: use the operand as term" in
    let opd' = aux (List.filter (fun v -> type_of v = ty_opd) llvs_same_size) in
    let ty_i1 =
      if tycls_opd = Integer then i1_type llctx
      else vector_type (i1_type llctx) (vector_size ty_opd)
    in
    let llvs_i1 = List.filter (fun v -> type_of v = ty_i1) llvs_same_size in
    let cond =
      if llvs_i1 = [] then get_rand_const ty_i1 else AUtil.choose_random llvs_i1
    in
    build_select cond opd opd' "" builder

(** [create_rand_instr llctx llm] creates a random instruction. *)
let create_rand_instr llctx llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in

  (* 1. the location must not precede PHI nodes
     2. the location must have at least one available non-const llv,
        note that void instrs cannot be operands,
        and we will not create MEM instrs *)
  let not_void_or_ptr llv =
    let tycls = llv |> type_of |> classify_type in
    tycls <> Void && tycls <> Pointer
  in
  let cands_loc =
    fold_left_all_instr (fun accu instr -> instr :: accu) [] f
    |> List.filter (fun i -> instr_opcode i <> PHI)
    |> List.filter (fun i ->
           i
           |> get_opd_cands_nonconst_allty
           |> List.filter not_void_or_ptr
           <> [])
  in
  if cands_loc = [] then None
  else
    let loc = AUtil.choose_random cands_loc in
    L.debug "location: %s" (string_of_llvalue loc);

    let opd =
      loc
      |> get_opd_cands_nonconst_allty
      |> List.filter not_void_or_ptr
      |> AUtil.choose_random
    in
    L.debug "operand: %s" (string_of_llvalue opd);
    let ty_opd = type_of opd in
    let tycls_opd = classify_type ty_opd in
    assert (tycls_opd = Integer || tycls_opd = Vector);

    let ty_dst_trunc = get_dst_tys Trunc ty_opd in
    let ty_dst_ext = get_dst_tys ZExt ty_opd in

    (* choose proper opcode *)
    let opc =
      let cands_opc = Opcode.ICmp :: Select :: Array.to_list OpCls.binary_arr in
      let cands_opc =
        if ty_dst_trunc = [] then cands_opc else Trunc :: cands_opc
      in
      let cands_opc =
        if ty_dst_ext = [] then cands_opc else ZExt :: SExt :: cands_opc
      in
      AUtil.choose_random cands_opc
    in
    L.debug "opcode: %s" (string_of_opcode opc);

    (* create instruction by opcls *)
    (match OpCls.classify opc with
    | BINARY ->
        let opd' = get_rand_opd loc ty_opd in
        create_binary llctx loc opc opd opd'
    | CAST ->
        let ty_dst =
          AUtil.choose_random (if opc = Trunc then ty_dst_trunc else ty_dst_ext)
        in
        create_cast llctx loc opc opd ty_dst
    | OTHER ICmp ->
        let cond = OpCls.random_icmp () in
        let opd' = get_rand_opd loc ty_opd in
        create_icmp llctx loc cond opd opd'
    | OTHER Select -> create_rand_select llctx loc opd
    | _ -> failwith "NEVER OCCUR")
    |> ignore;
    Some llm

(** [subst_rand_instr llctx llm] substitutes a random instruction into another
      random instruction of the same [OpCls.t], with the same operands.
      Note: flags are not preserved. *)
let subst_rand_instr llctx llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in

  (* choose target instruction, possible opcls are:
     BINARY, CAST(Ext), OTHER(ICmp) *)
  let is_tgt i =
    match OpCls.opcls_of i with
    | BINARY -> true
    | CAST -> instr_opcode i <> Trunc
    | OTHER ICmp -> true
    | _ -> false
  in
  let cands_instr = List.filter is_tgt all_instrs in

  if cands_instr = [] then None
  else
    let instr = AUtil.choose_random cands_instr in
    let opc_old = instr_opcode instr in
    match OpCls.classify opc_old with
    | BINARY ->
        let opc_new = OpCls.random_binary_except opc_old in
        subst_binary llctx instr opc_new |> ignore;
        Some llm
    | CAST ->
        subst_cast llctx instr |> ignore;
        Some llm
    | OTHER ICmp ->
        let pred_old = icmp_predicate instr |> Option.get in
        let pred_new = OpCls.random_icmp_except pred_old in
        subst_icmp llctx instr pred_new |> ignore;
        Some llm
    | _ -> failwith "NEVER OCCUR"

let count_const_opds instr =
  let rec loop accu i =
    if i >= num_operands instr then accu
    else loop (accu + if is_constant (operand instr i) then 1 else 0) (i + 1)
  in
  loop 0 0

let invest_opd_alts instr =
  let num_opds = num_operands instr in
  let cnt = count_const_opds instr in
  (* TODO: below assertion is broken due to alloca.
     assert (num_opds = 0 || cnt < num_opds); *)
  let can_be_const opd = if cnt + 1 = num_opds then is_constant opd else true in

  let rec loop accu i =
    if i >= num_opds then accu
    else
      let opd = operand instr i in
      match get_alternate instr ~include_const:(can_be_const opd) opd with
      | None -> loop accu (i + 1)
      | Some alt -> loop ((i, alt) :: accu) (i + 1)
  in
  loop [] 0

(** [subst_rand_opd llctx llm] substitutes an operand of an instruction into
    another available one, randomly. *)
let subst_rand_opd llctx llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in

  let cands =
    all_instrs
    |> List.map (fun instr -> (instr, invest_opd_alts instr))
    |> List.filter (fun (_, alts) -> alts <> [])
  in
  if cands = [] then None
  else
    let instr, alts = AUtil.choose_random cands in
    if instr_opcode instr = ICmp && AUtil.rand_bool () then (
      let icmp =
        instr |> icmp_predicate |> Option.get |> OpCls.random_icmp_except
      in
      subst_icmp llctx instr icmp |> ignore;
      Some llm)
    else
      let alt = AUtil.choose_random alts in
      L.debug "instr: %s" (string_of_llvalue instr);
      L.debug "substitute operand %d to %s" (fst alt)
        (string_of_llvalue (snd alt));
      set_operand instr (fst alt) (snd alt);
      Some llm

let edit_overflow instr =
  let open Flag in
  assert (instr |> instr_opcode |> can_overflow);
  let cases =
    match (is_nuw instr, is_nsw instr) with
    | false, false -> [ (false, true); (true, false); (true, true) ]
    | false, true -> [ (false, false); (true, false); (true, true) ]
    | true, false -> [ (false, false); (false, true); (true, true) ]
    | true, true -> [ (false, false); (false, true); (true, false) ]
  in
  let nuw_new, nsw_new = AUtil.choose_random cases in
  set_nuw nuw_new instr;
  set_nsw nsw_new instr

let edit_be_exact instr =
  let open Flag in
  assert (instr |> instr_opcode |> can_be_exact);
  set_exact (not (is_exact instr)) instr

(** [modify_flag llctx llm] grants/retrieves flag to/from an instr randomly. *)
let modify_flag _llctx llm =
  let open Flag in
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in
  let can_overflow i = i |> instr_opcode |> can_overflow in
  let can_be_exact i = i |> instr_opcode |> can_be_exact in
  let instrs_overflow = List.filter can_overflow all_instrs in
  let instrs_be_exact = List.filter can_be_exact all_instrs in

  let ret = Some llm in
  match (instrs_overflow, instrs_be_exact) with
  | [], [] -> None
  | _, [] ->
      instrs_overflow |> AUtil.choose_random |> edit_overflow;
      ret
  | [], _ ->
      instrs_be_exact |> AUtil.choose_random |> edit_be_exact;
      ret
  | _ ->
      let i =
        instrs_overflow
        |> List.rev_append instrs_be_exact
        |> AUtil.choose_random
      in
      (* no opcode can be both *)
      if can_overflow i then edit_overflow i else edit_be_exact i;
      ret

type collect_ty_res_t = Impossible | Retry | Success of lltype LLVMap.t

(* CAST instructions directly affects to types, need special caring *)
let rec trav_cast llv ty_new accu =
  match classify_value llv with
  | Instruction opc
    when (OpcodeClass.classify opc = CAST && type_of llv = ty_new)
         || operand llv 0 |> type_of = ty_new ->
      Retry
  | _ when llv |> type_of = ty_new -> Retry
  | _ -> (
      match (llv |> type_of |> classify_type, classify_type ty_new) with
      | Integer, Integer -> accu
      | Integer, Vector ->
          collect_ty_changing_llvs llv
            (vector_type (type_of llv) (vector_size ty_new))
            accu
      | Vector, Integer ->
          collect_ty_changing_llvs llv (llv |> type_of |> element_type) accu
      | Vector, Vector ->
          collect_ty_changing_llvs llv
            (vector_type (llv |> type_of |> element_type) (vector_size ty_new))
            accu
      | _ -> failwith "Unsupported typekind")

(** [trav_llvs_used_by_curr curr ty_new accu] propagates type inference to
    values USED BY [curr] (operands). *)
and trav_llvs_used_by_curr curr ty_new accu =
  match classify_value curr with
  | Instruction opc -> (
      match OpcodeClass.classify opc with
      | MEM _ -> accu
      | CAST -> trav_cast (operand curr 0) ty_new accu
      | BINARY ->
          let opd0 = operand curr 0 in
          let opd1 = operand curr 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 ty_new
      | OTHER PHI ->
          (* propagate over all incoming values *)
          List.fold_left
            (fun accu (i, _) -> collect_ty_changing_llvs i ty_new accu)
            accu (incoming curr)
      | OTHER Select ->
          let opd1 = operand curr 1 in
          let opd2 = operand curr 2 in
          accu
          |> collect_ty_changing_llvs opd1 ty_new
          |> collect_ty_changing_llvs opd2 ty_new
      | _ -> failwith "NEVER OCCUR")
  | _ -> accu

(** [trav_llvs_using_curr curr ty_new accu] propagates type inference to values
    USING [curr] (users of curr). *)
and trav_llvs_using_curr curr ty_new accu =
  fold_left_uses
    (fun accu use ->
      let user = user use in
      match OpCls.opcls_of user with
      | TER _ | MEM _ -> (* does not affect *) accu
      | CAST -> trav_cast user ty_new accu
      | BINARY | OTHER PHI | OTHER Select ->
          collect_ty_changing_llvs user ty_new accu
      | OTHER ICmp ->
          (* preserve type equality of both operands *)
          let opd0 = operand user 0 in
          let opd1 = operand user 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 ty_new
      | _ -> failwith "NEVER OCCUR")
    accu curr

(** [collect_ty_changing_llvs llv ty_new accu] recursively accumulates type
    information to [accu] when [llv] changes to [ty_new].
    The return is wrapped by [Option] to represent impossible cases. *)
and collect_ty_changing_llvs llv ty_new accu =
  match accu with
  | Success accu_inner when LLVMap.mem llv accu_inner -> accu
  | Success _ when is_constant llv -> accu
  | Success accu -> (
      let accu = LLVMap.add llv ty_new accu in
      match classify_value llv with
      | Instruction opc ->
          if opc = ICmp then Impossible
          else
            Success accu
            |> trav_llvs_used_by_curr llv ty_new
            |> trav_llvs_using_curr llv ty_new
      | _ -> Success accu |> trav_llvs_using_curr llv ty_new)
  | _ -> accu

let get_ty llv_old typemap =
  match LLVMap.find_opt llv_old typemap with
  | Some ty -> ty
  | None -> type_of llv_old

(** [move_signature llctx f_old typemap] returns new signature of [f_old]
    according to [typemap]. *)
let move_signature llctx f_old typemap =
  let ret = get_return_instr f_old |> Option.get in
  let ret_ty =
    if num_operands ret = 0 then void_type llctx
    else get_ty (operand ret 0) typemap
  in
  let param_tys = f_old |> params |> Array.map (Fun.flip get_ty typemap) in
  (ret_ty, param_tys)

(** [copy_blocks llctx f_old f_new] copies all blocks of [f_old] to [f_new]. *)
let copy_blocks llctx f_old f_new =
  assert (f_new |> basic_blocks |> Array.length = 1);
  let entry_new = entry_block f_new in
  let blocks_old = basic_blocks f_old in
  let rec loop prev_block i =
    if i >= Array.length blocks_old then ()
    else
      let block_old = Array.get blocks_old i in
      let block_new = insert_block llctx (block_name block_old) entry_new in
      move_block_after prev_block block_new;
      loop block_new (i + 1)
  in
  loop entry_new 1

let migrate_const llv_old ty_new =
  assert (is_constant llv_old);
  if is_poison llv_old then poison ty_new
  else if is_undef llv_old then undef ty_new
  else
    match (llv_old |> type_of |> classify_type, classify_type ty_new) with
    | Pointer, _ -> const_null ty_new
    | Integer, Integer ->
        const_int ty_new
          (llv_old |> int64_of_const |> Option.get |> Int64.to_int)
    | Integer, Vector ->
        let el_ty = element_type ty_new in
        let vec_size = vector_size ty_new in
        let llv_arr =
          Array.make vec_size
            (const_int el_ty
               (llv_old |> int64_of_const |> Option.get |> Int64.to_int))
        in
        const_vector llv_arr
    | Vector, Integer ->
        const_int ty_new
          (aggregate_element llv_old 0
          |> Option.get
          |> int64_of_const
          |> Option.get
          |> Int64.to_int)
    | Vector, Vector ->
        let el_ty = element_type ty_new in
        let vec_size = vector_size ty_new in
        let llv_arr =
          Array.make vec_size
            (const_int el_ty
               (aggregate_element llv_old 0
               |> Option.get
               |> int64_of_const
               |> Option.get
               |> Int64.to_int))
        in
        const_vector llv_arr
    | _ -> failwith "Unsupported type migration"

let migrate_self llv link_v =
  if is_constant llv then migrate_const llv (type_of llv)
  else LLVMap.find llv link_v

let migrate_to_other_ty llv ty link_v =
  if is_constant llv then migrate_const llv ty else LLVMap.find llv link_v

let migrate_ter builder instr_old link_v link_b =
  match instr_opcode instr_old with
  | Ret ->
      if num_operands instr_old = 0 then build_ret_void builder
      else build_ret (migrate_self (operand instr_old 0) link_v) builder
  | Br -> (
      let find_block = Fun.flip LLBMap.find link_b in
      match get_branch instr_old with
      | Some (`Conditional (cond, tb, fb)) ->
          build_cond_br (migrate_self cond link_v) (find_block tb)
            (find_block fb) builder
      | Some (`Unconditional dest) -> build_br (find_block dest) builder
      | None -> failwith "Not supporting other kind of branches")
  | _ -> failwith "NEVER OCCUR"

let migrate_binary builder instr_old typemap link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let opc = instr_opcode instr_old in

  let opd0, opd1 =
    match (is_constant opd0, is_constant opd1) with
    | true, true -> (
        match LLVMap.find_opt instr_old typemap with
        | Some ty_new ->
            let opd0 = migrate_to_other_ty opd0 ty_new link_v in
            let opd1 = migrate_to_other_ty opd1 ty_new link_v in
            (opd0, opd1)
        | None ->
            let opd0 = migrate_self opd0 link_v in
            let opd1 = migrate_self opd1 link_v in
            (opd0, opd1))
    | true, false ->
        let opd1 = migrate_self opd1 link_v in
        let opd0 = migrate_to_other_ty opd0 (type_of opd1) link_v in
        (opd0, opd1)
    | false, true ->
        let opd0 = migrate_self opd0 link_v in
        let opd1 = migrate_to_other_ty opd1 (type_of opd0) link_v in
        (opd0, opd1)
    | false, false ->
        let opd0 = migrate_self opd0 link_v in
        let opd1 = migrate_self opd1 link_v in
        (opd0, opd1)
  in
  OpCls.build_binary opc opd0 opd1 builder

let migrate_mem builder instr_old typemap link_v =
  match instr_opcode instr_old with
  | Alloca -> build_alloca (get_allocated_type instr_old) "" builder
  | Load ->
      let opd = operand instr_old 0 in
      build_load (get_ty instr_old typemap) (migrate_self opd link_v) "" builder
  | Store ->
      build_store
        (migrate_self (operand instr_old 0) link_v)
        (migrate_self (operand instr_old 1) link_v)
        builder
  | _ -> failwith "NEVER OCCUR"

let migrate_cast builder instr_old typemap link_v =
  let opd = operand instr_old 0 in
  let dest_ty = get_ty instr_old typemap in
  let opd =
    match (opd |> type_of |> classify_type, dest_ty |> classify_type) with
    | Integer, Integer | Vector, Vector -> migrate_self opd link_v
    | Integer, Vector ->
        let vec_size = vector_size dest_ty in
        let ty_new = vector_type (type_of opd) vec_size in
        migrate_to_other_ty opd ty_new link_v
    | Vector, Integer ->
        let ty_new = opd |> type_of |> element_type in
        migrate_to_other_ty opd ty_new link_v
    | _, _ -> failwith "un supported types"
  in

  (* decide whether we have to use extension or truncation *)
  let is_trunc =
    if classify_type dest_ty = Integer then
      integer_bitwidth dest_ty < (opd |> type_of |> integer_bitwidth)
    else
      dest_ty
      |> element_type
      |> integer_bitwidth
      < (opd |> type_of |> element_type |> integer_bitwidth)
  in

  (* FIXME: for now, using ZExt only *)
  (if is_trunc then build_trunc
   else if instr_opcode instr_old = SExt then build_sext
   else if instr_opcode instr_old = ZExt then build_zext
   else if Random.bool () then build_sext
   else build_zext)
    opd dest_ty "" builder

let migrate_icmp builder instr_old link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let build_icmp o0 o1 =
    OpCls.build_icmp (icmp_predicate instr_old |> Option.get) o0 o1 builder
  in

  let opd0, opd1 =
    match (is_constant opd0, is_constant opd1) with
    | true, true | false, false ->
        let opd0 = migrate_self opd0 link_v in
        let opd1 = migrate_self opd1 link_v in
        (opd0, opd1)
    | true, false ->
        let opd1 = migrate_self opd1 link_v in
        let opd0 = migrate_to_other_ty opd0 (type_of opd1) link_v in
        (opd0, opd1)
    | false, true ->
        let opd0 = migrate_self opd0 link_v in
        let opd1 = migrate_to_other_ty opd1 (type_of opd0) link_v in
        (opd0, opd1)
  in
  build_icmp opd0 opd1

let migrate_phi builder instr_old typemap =
  let phi_ty = get_ty instr_old typemap in
  build_empty_phi phi_ty "" builder

let migrate_select builder instr_old typemap link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let opd2 = operand instr_old 2 in

  let opd0 = migrate_self opd0 link_v in
  let opd1, opd2 =
    match (is_constant opd1, is_constant opd2) with
    | true, true -> (
        match LLVMap.find_opt instr_old typemap with
        | Some ty_new ->
            let opd1 = migrate_to_other_ty opd1 ty_new link_v in
            let opd2 = migrate_to_other_ty opd2 ty_new link_v in
            (opd1, opd2)
        | None ->
            let opd1 = migrate_self opd1 link_v in
            let opd2 = migrate_self opd2 link_v in
            (opd1, opd2))
    | true, false ->
        let opd2 = migrate_self opd2 link_v in
        let opd1 = migrate_to_other_ty opd1 (type_of opd2) link_v in
        (opd1, opd2)
    | false, true ->
        let opd1 = migrate_self opd1 link_v in
        let opd2 = migrate_to_other_ty opd2 (type_of opd1) link_v in
        (opd1, opd2)
    | false, false ->
        let opd1 = migrate_self opd1 link_v in
        let opd2 = migrate_self opd2 link_v in
        (opd1, opd2)
  in
  build_select opd0 opd1 opd2 "" builder

let migrate_instr builder instr_old typemap link_v link_b =
  let instr_new =
    match OpCls.opcls_of instr_old with
    | TER _ -> migrate_ter builder instr_old link_v link_b
    | BINARY -> migrate_binary builder instr_old typemap link_v
    | MEM _ -> migrate_mem builder instr_old typemap link_v
    | CAST -> migrate_cast builder instr_old typemap link_v
    | OTHER ICmp -> migrate_icmp builder instr_old link_v
    | OTHER PHI -> migrate_phi builder instr_old typemap
    | OTHER Select -> migrate_select builder instr_old typemap link_v
    | _ -> failwith "Unsupported instruction"
  in
  if instr_old |> type_of |> classify_type <> Void then
    set_value_name (value_name instr_old) instr_new;
  LLVMap.add instr_old instr_new link_v

let migrate_block llctx b_old b_new typemap link_v link_b =
  let builder = builder_at_end llctx b_new in
  (* NOTE: Incomings of PHI nodes must be added later *)
  let link_v =
    fold_left_instrs
      (fun link_v instr_old ->
        migrate_instr builder instr_old typemap link_v link_b)
      link_v b_old
  in
  let rec loop = function
    | At_end _ -> ()
    | Before phi_old ->
        if instr_opcode phi_old <> PHI then ()
        else
          let phi_new = LLVMap.find phi_old link_v in
          let incomings_old = incoming phi_old in
          List.iter
            (fun (v, b) ->
              add_incoming
                ( (if is_constant v then v else LLVMap.find v link_v),
                  LLBMap.find b link_b )
                phi_new)
            incomings_old;
          phi_old |> instr_succ |> loop
  in
  loop (instr_begin b_old);
  link_v

(** [migrate llctx f_old f_new typemap] migrates contents of [f_old] to [f_new].
    [typemap] must be provided. *)
let migrate llctx f_old f_new typemap =
  let blocks_old = basic_blocks f_old in
  let blocks_new = basic_blocks f_new in

  (* set initial link *)
  let params_old = params f_old in
  let params_new = params f_new in
  assert (Array.length params_old = Array.length params_new);
  let rec loop accu i =
    if i >= Array.length params_old then accu
    else
      let accu' =
        LLVMap.add (Array.get params_old i) (Array.get params_new i) accu
      in
      loop accu' (i + 1)
  in
  let link_v = loop LLVMap.empty 0 in
  let link_b =
    Array.map2 (fun b_old b_new -> (b_old, b_new)) blocks_old blocks_new
    |> Array.to_seq
    |> LLBMap.of_seq
  in

  (* migrate blocks *)
  let rec loop accu i =
    if i >= Array.length blocks_old then accu
    else
      let accu' =
        migrate_block llctx (Array.get blocks_old i) (Array.get blocks_new i)
          typemap accu link_b
      in
      loop accu' (i + 1)
  in
  loop link_v 0 |> ignore

(** [redef_fn llctx f_old typemap] redefines and returns new version of [f_old]
    according to [typemap]. *)
let redef_fn llctx f_old typemap =
  let ret_ty, param_tys = move_signature llctx f_old typemap in
  let f_new =
    define_function "" (function_type ret_ty param_tys) (global_parent f_old)
  in
  Array.iteri
    (fun i param_new -> set_value_name (value_name (param f_old i)) param_new)
    (params f_new);
  copy_blocks llctx f_old f_new;
  migrate llctx f_old f_new typemap;
  f_new

let verify_and_clean f_old f_new =
  if Llvm_analysis.verify_function f_new then (
    let f_name = value_name f_old in
    delete_function f_old;
    set_value_name f_name f_new;
    Some f_new)
  else (
    delete_function f_new;
    None)

let check_target_for_change_type target f =
  if
    target |> type_of |> classify_type = Void
    || target |> type_of |> classify_type = Pointer
  then false
  else if classify_value target = Argument then true
  else if
    OpCls.opcls_of target = OTHER ICmp
    || fold_left_all_instr
         (fun accu i -> accu || OpCls.opcls_of i = UNSUPPORTED)
         false f
  then false
  else true

(** [change_type llctx llm] changes type of a random instruction.
    All the other associated values are recursively changed. *)
let change_type llctx llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let f_params =
    f |> params |> Array.to_list
    (* |> List.filter (fun param ->
           match use_begin param with Some _ -> true | None -> false) *)
  in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in
  let target = AUtil.choose_random (all_instrs @ f_params) in
  L.debug "instr: %s" (string_of_llvalue target);
  (* CONSIDER IMPOSSIBLE CASES *)
  if check_target_for_change_type target f then (
    (* decide type *)
    let ty_old = type_of target in

    (* Ensure each llvalue has its own name.
       This is necessary because we will use value names as key *)
    reset_var_names f;

    let rec loop () =
      let ty_new = AUtil.choose_random !Config.interesting_types in
      if ty_old = ty_new then loop ()
      else
        match collect_ty_changing_llvs target ty_new (Success LLVMap.empty) with
        | Impossible -> None
        | Retry -> loop ()
        | Success typemap ->
            L.debug "ty_old: %s, ty_new: %s@." (string_of_lltype ty_old)
              (string_of_lltype ty_new);
            let f_new = redef_fn llctx f typemap in
            verify_and_clean f f_new |> ignore;
            Some llm
    in
    loop ())
  else None

let delete_empty_blocks func =
  let open Util in
  ALlvm.fold_left_blocks
    (fun accu blk ->
      match ALlvm.instr_begin blk with
      | ALlvm.At_end _ -> blk :: accu
      | ALlvm.Before _ -> accu)
    [] func
  |> List.iter ALlvm.delete_block

let func_terminators func =
  let open Util in
  ALlvm.fold_left_blocks
    (fun accu blk ->
      match ALlvm.block_terminator blk with
      | Some term -> term :: accu
      | None -> accu)
    [] func

(** [cut_below llctx llm] cuts all instructions below from a random point. *)
let cut_below llctx llm =
  let open Util in
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in
  let instr_tgt = AUtil.choose_random all_instrs in

  let f_old = ALlvm.get_function instr_tgt in
  let instrs = ALlvm.fold_left_all_instr (fun accu i -> i :: accu) [] f_old in

  match instrs with
  | [] | [ _ ] | [ _; _ ] -> None
  | _ -> (
      (* target: new instruction will returned.*)
      let target = ALlvm.get_instr_before ~wide:true instr_tgt in
      match target with
      | Some tgt when ALlvm.is_assignment (ALlvm.instr_opcode tgt) ->
          let rec succ_instrs accu curr =
            match ALlvm.instr_succ curr with
            | ALlvm.At_end _ -> accu
            | ALlvm.Before next -> succ_instrs (next :: accu) next
          in

          let rec succ_blocks accu curr =
            match ALlvm.block_succ curr with
            | ALlvm.At_end _ -> accu
            | ALlvm.Before next -> succ_blocks (next :: accu) next
          in

          (* delete all succeeding instructions and blocks*)
          succ_instrs [] tgt |> List.iter ALlvm.delete_instruction;
          succ_blocks [] (ALlvm.instr_parent tgt)
          |> List.iter ALlvm.delete_block;

          (* delete all remaining terminating instructions *)
          func_terminators f_old |> List.iter ALlvm.delete_instruction;
          delete_empty_blocks f_old;

          (* move instructions in other blocks to the entry block *)
          let entry = ALlvm.entry_block f_old in
          let other_blocks =
            ALlvm.fold_left_blocks
              (fun accu blk -> if blk = entry then accu else blk :: accu)
              [] f_old
          in
          List.iter (ALlvm.transfer_instructions entry) other_blocks;

          (* add ret which returns tgt *)
          ALlvm.builder_at_end llctx (ALlvm.instr_parent tgt)
          |> ALlvm.build_ret tgt
          |> ignore;

          (* transferring could leave some blocks empty *)
          (* delete empty blocks *)
          delete_empty_blocks f_old;

          let new_ret_ty = ALlvm.type_of tgt in
          let _f_new = ALlvm.clone_function f_old new_ret_ty in
          ALlvm.delete_function f_old;

          Some llm
      | _ -> None)

(* inner-basicblock mutation (independent of block CFG) *)
let rec mutate_inner_bb llctx mode llm score =
  let mutation = choose_mutation mode score in
  L.info "mutation(%a): %a" pp_mode mode pp_mutation mutation;
  (* L.debug "before:\n%s" (string_of_llmodule llm); *)
  let mutation_result =
    match mutation with
    | CREATE ->
        (* create_rand_instr llctx llm *)
        None
    | OPCODE -> subst_rand_instr llctx llm
    | OPERAND -> subst_rand_opd llctx llm
    | FLAG -> modify_flag llctx llm
    | TYPE -> change_type llctx llm
    | CUT -> cut_below llctx llm
  in
  match mutation_result with
  | Some llm ->
      L.debug "mutant: %s" (string_of_llmodule llm);
      llm
  | None ->
      L.debug "None";
      mutate_inner_bb llctx mode llm score

let run llctx (seed : Seedcorpus.Seedpool.seed_t) =
  let mode = if seed.covers then FOCUS else EXPAND in
  mutate_inner_bb llctx mode seed.llm (int_of_float seed.score)
(* |> mutate_CFG |> check_retval llctx *)
