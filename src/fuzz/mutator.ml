open Util.ALlvm
module AUtil = Util.AUtil
module OpCls = OpcodeClass
module L = Logger

type mode_t = EXPAND | FOCUS
type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE | CUT

let pp_mutation fmt m =
  match m with
  | CREATE -> Format.fprintf fmt "CREATE"
  | OPCODE -> Format.fprintf fmt "OPCODE"
  | OPERAND -> Format.fprintf fmt "OPERAND"
  | FLAG -> Format.fprintf fmt "FLAG"
  | TYPE -> Format.fprintf fmt "TYPE"
  | CUT -> Format.fprintf fmt "CUT"

(* choose mutation *)
let choose_mutation mode score =
  match mode with
  | EXPAND ->
      let mutations =
        [
          (CREATE, 3); (OPCODE, 3); (OPERAND, 3); (FLAG, 3); (TYPE, 2); (CUT, 1);
        ]
        |> List.map (fun (m, p) -> List.init p (Fun.const m))
        |> List.flatten
        |> Array.of_list
      in
      (* FIXME: highly skewed to CREATE if score is very big *)
      let r = Random.int (score + Array.length mutations) in
      if r <= score then mutations.(0) else mutations.(r - score)
  | FOCUS ->
      let mutations = [| OPCODE; OPERAND; FLAG; TYPE |] in
      let r = Random.int (Array.length mutations) in
      mutations.(r)

(* CFG PRESERVING MUTATION HELPERS *)

(* create_[CLASS] llctx loc [args]+ creates corresponding instruction,
   right before instruction [loc], without any extra keywords.
   Returns the new instruction. *)

let create_binary llctx loc opcode o0 o1 =
  (OpCls.build_binary opcode) o0 o1 (builder_before llctx loc)

let create_cast llctx loc opcode o ty =
  (OpCls.build_cast opcode) o ty (builder_before llctx loc)

let create_cmp llctx loc icmp o0 o1 =
  (OpCls.build_cmp icmp) o0 o1 (builder_before llctx loc)

(** [exchange_binary llctx instr] exchanges the two operands of the binary
    instruction [instr], without any extra keywords.
    Returns the new instruction. *)
let exchange_binary llctx instr =
  let nth_opd i = operand instr i in
  let new_instr =
    create_binary llctx instr (instr_opcode instr) (nth_opd 1) (nth_opd 0)
  in
  replace_and_ret instr new_instr

(* subst_[CLASS] llctx instr [args]+ substitutes the instruction [instr]
   into another possible instruction, with the same operands,
   without any extra keywords. Returns the new instruction. *)

let subst_binary llctx instr opcode =
  let nth_opd = operand instr in
  let new_instr = create_binary llctx instr opcode (nth_opd 0) (nth_opd 1) in
  replace_and_ret instr new_instr |> Option.some

let subst_cast llctx instr =
  (* ZExt -> SExt, SExt -> ZExt, Trunc -> Trunc (None) *)
  match instr_opcode instr with
  | ZExt ->
      let new_instr =
        create_cast llctx instr Opcode.SExt (operand instr 0) (type_of instr)
      in
      replace_and_ret instr new_instr |> Option.some
  | SExt ->
      let new_instr =
        create_cast llctx instr Opcode.ZExt (operand instr 0) (type_of instr)
      in
      replace_and_ret instr new_instr |> Option.some
  | Trunc -> None
  | _ -> raise OpCls.Improper_class

let subst_cmp llctx instr icmp =
  let nth_opd = operand instr in
  let new_instr = create_cmp llctx instr icmp (nth_opd 0) (nth_opd 1) in
  replace_and_ret instr new_instr

(* HIGH-LEVEL MUTATION HELPERS *)

(** [randget_operand llctx loc ty] gets, or generates
    a llvalue as an operand, of type [ty], valid at [loc], if possible.
    NOTE: if [ty] is an integer type, this will always return [Some(_)]. *)
let randget_operand loc ty =
  let candidates =
    loc |> get_instrs_before ~wide:false |> list_filter_type ty
  in
  let candidates =
    match classify_type ty with
    | TypeKind.Integer ->
        const_int ty (AUtil.choose_random !Config.interesting_integers)
        :: candidates
    | Vector ->
        (* TODO: check this *)
        let el_ty = element_type ty in
        let vec_size = vector_size ty in
        let llv_arr =
          Array.make vec_size
            (const_int el_ty (AUtil.choose_random !Config.interesting_integers))
        in
        const_vector llv_arr :: candidates
    | _ -> candidates
  in
  let candidates =
    loc
    |> get_function
    |> fold_left_params
         (fun candidates param ->
           if type_of param = ty then param :: candidates else candidates)
         candidates
  in
  if candidates <> [] then Some (AUtil.choose_random candidates) else None

(** [create_rand_instr llctx preferred_opd loc] creates
    a random instruction before instruction [loc],
    with lists of available arguments declared prior to [loc]. *)
let create_rand_instr llctx preferred_opd loc =
  let preds = get_instrs_before ~wide:false loc in
  let preds =
    preds @ (loc |> instr_parent |> block_parent |> params |> Array.to_list)
  in

  let operand =
    match preferred_opd with
    | Some pref_opd -> pref_opd
    | None ->
        if preds <> [] then AUtil.choose_random preds
        else
          randget_operand loc
            (AUtil.choose_random !Config.interesting_integer_types)
          |> Option.get
  in
  let operand_ty = type_of operand in
  let is_integer = classify_type operand_ty = Integer in

  let opcode = OpCls.random_opcode () in
  match OpCls.classify opcode with
  | BINARY when is_integer ->
      create_binary llctx loc opcode operand
        (randget_operand loc operand_ty |> Option.get)
      |> Option.some
  | CAST when is_integer ->
      let pred =
        let operand_bw = integer_bitwidth operand_ty in
        fun ty ->
          (if opcode = Trunc then ( < ) else ( > ))
            (integer_bitwidth ty) operand_bw
      in
      let candidates = List.filter pred !Config.interesting_integer_types in
      if candidates = [] then None
      else
        let dest_ty = AUtil.choose_random candidates in
        create_cast llctx loc opcode operand dest_ty |> Option.some
  | CMP when is_integer ->
      create_cmp llctx loc
        (AUtil.choose_random OpCls.cmp_kind)
        operand
        (randget_operand loc operand_ty |> Option.get)
      |> Option.some
  | MEM ->
      if opcode = Load && classify_type operand_ty = Pointer then
        Some
          (build_load
             (AUtil.choose_random !Config.interesting_integer_types)
             operand "" (builder_before llctx loc))
      else None
  | _ -> None

(** [subst_rand_instr llctx instr] substitutes
    the instruction [instr] into another random instruction in its class,
    with the same operands. *)
let subst_rand_instr llctx instr =
  let old_opcode = instr_opcode instr in
  match OpCls.classify old_opcode with
  | BINARY ->
      if is_noncommutative_binary instr then
        if AUtil.rand_bool () then exchange_binary llctx instr |> Option.some
        else
          let new_opcode = OpCls.random_opcode_except old_opcode in
          subst_binary llctx instr new_opcode
      else
        let new_opcode = OpCls.random_opcode_except old_opcode in
        subst_binary llctx instr new_opcode
  | CAST -> subst_cast llctx instr
  | CMP ->
      let old_cmp = instr |> icmp_predicate |> Option.get in
      let rec aux () =
        let cmp = OpCls.random_cmp () in
        if cmp = old_cmp then aux () else subst_cmp llctx instr cmp
      in
      aux () |> Option.some
  | _ -> None

(** [subst_rand_opd llctx preferred_opd instr] substitutes
    a random operand of instruction [instr]
    into another available random one. *)
let rec subst_rand_opd llctx preferred_opd instr =
  let num_operands = num_operands instr in
  let opd_i = operand instr in
  let use_other_opd () = subst_rand_opd llctx None instr in

  match preferred_opd with
  | Some preferred_opd -> (
      let preferred_ty = type_of preferred_opd in
      let check_ty llv = type_of llv = preferred_ty in
      match OpCls.opcls_of instr with
      | (BINARY | CAST | CMP) when num_operands > 0 -> (
          match num_operands with
          | 1 ->
              let operand_old = opd_i 0 in
              if check_ty operand_old then
                Some (set_opd_and_ret instr 0 preferred_opd)
              else use_other_opd ()
          | 2 -> (
              (* try best to use the preferred operand *)
              match (check_ty (opd_i 0), check_ty (opd_i 1)) with
              | false, false -> use_other_opd ()
              | false, true -> Some (set_opd_and_ret instr 1 preferred_opd)
              | true, false -> Some (set_opd_and_ret instr 0 preferred_opd)
              | true, true ->
                  (* both are ok; replace random one into the preferred one *)
                  let i = Random.int 2 in
                  Some (set_opd_and_ret instr i preferred_opd))
          | _ -> None)
      | _ -> None)
  | None ->
      if num_operands > 0 then
        let i = Random.int num_operands in
        let operand_old = opd_i i in
        randget_operand instr (type_of operand_old)
        |> Option.map (set_opd_and_ret instr i)
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
        let nuw_new, nsw_new = AUtil.choose_random cases in
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
(* let make_chain llctx len first_opd instr =
   assert (len >= 2);
   let create pref = create_rand_instr llctx pref instr in
   let rec aux i accu =
     if i = 1 then accu else aux (i - 1) (Some (create accu |> Option.get))
   in
   subst_rand_opd llctx (aux len first_opd) instr *)

let rec trav_cast llv ty_new accu =
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
  | _ -> failwith "Unsupported typekind"

and trav_llvs_used_by_curr curr ty_new accu =
  match classify_value curr with
  | Instruction opc -> (
      match OpcodeClass.classify opc with
      | MEM -> accu
      | CAST -> trav_cast (operand curr 0) ty_new accu
      | BINARY ->
          let opd0 = operand curr 0 in
          let opd1 = operand curr 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 ty_new
      | PHI ->
          (* propagate over all incoming values *)
          List.fold_left
            (fun accu (i, _) -> collect_ty_changing_llvs i ty_new accu)
            accu (incoming curr)
      | _ -> failwith "NEVER OCCUR")
  | _ -> accu

and trav_llvs_using_curr curr ty_new accu =
  fold_left_uses
    (fun accu use ->
      let user = user use in
      match OpCls.opcls_of user with
      | TER | MEM -> (* does not affect *) accu
      | CAST -> trav_cast user ty_new accu
      | BINARY | PHI -> collect_ty_changing_llvs user ty_new accu
      | CMP ->
          if classify_type ty_new = Vector then None
          else
            (* preserve type equality of both operands *)
            let opd0 = operand user 0 in
            let opd1 = operand user 1 in
            accu
            |> collect_ty_changing_llvs opd0 ty_new
            |> collect_ty_changing_llvs opd1 ty_new
      | _ -> failwith "NEVER OCCUR")
    accu curr

and collect_ty_changing_llvs llv ty_new accu =
  match accu with
  | None -> None
  | Some accu_inner when LLVMap.mem llv accu_inner -> accu
  | Some _ when is_constant llv -> accu
  | Some accu -> (
      let accu = LLVMap.add llv ty_new accu in
      match classify_value llv with
      | Instruction opc ->
          if OpCls.classify opc = CMP then None
          else
            Some accu
            |> trav_llvs_used_by_curr llv ty_new
            |> trav_llvs_using_curr llv ty_new
      | _ -> Some accu |> trav_llvs_using_curr llv ty_new)

let get_ty llv_old typemap =
  match LLVMap.find_opt llv_old typemap with
  | Some ty -> ty
  | None -> type_of llv_old

let move_signature llctx f_old typemap =
  let ret = get_return_instr f_old |> Option.get in
  let ret_ty =
    if num_operands ret = 0 then void_type llctx
    else get_ty (operand ret 0) typemap
  in
  let param_tys = f_old |> params |> Array.map (Fun.flip get_ty typemap) in
  (ret_ty, param_tys)

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
  (if is_trunc then build_trunc else build_zext) opd dest_ty "" builder

let migrate_cmp builder instr_old link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let build_cmp o0 o1 =
    OpCls.build_cmp (icmp_predicate instr_old |> Option.get) o0 o1 builder
  in
  build_cmp (migrate_self opd0 link_v) (migrate_self opd1 link_v)

let migrate_phi builder instr_old typemap =
  let phi_ty = get_ty instr_old typemap in
  build_empty_phi phi_ty "" builder

let migrate_instr builder instr_old typemap link_v link_b =
  let instr_new =
    match OpCls.opcls_of instr_old with
    | TER -> migrate_ter builder instr_old link_v link_b
    | BINARY -> migrate_binary builder instr_old typemap link_v
    | MEM -> migrate_mem builder instr_old typemap link_v
    | CAST -> migrate_cast builder instr_old typemap link_v
    | CMP -> migrate_cmp builder instr_old link_v
    | PHI -> migrate_phi builder instr_old typemap
    | OTHER -> failwith "Unsupported instruction"
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

(** [change_type llctx ty_new instr] changes type of [instr] randomly.
    All the other associated values are recursively changed.
    Returns [Some(instr)] if success, or [None] else. *)
let change_type llctx instr =
  (* llv is instruction now *)
  let f = get_function instr in
  (* CONSIDER IMPOSSIBLE CASES *)
  if
    OpCls.opcls_of instr = CMP
    || instr |> type_of |> classify_type = Void
    || instr |> type_of |> classify_type = Pointer
    || fold_left_all_instr (fun accu i -> accu || OpCls.is_of i OTHER) false f
  then None
  else
    (* decide type *)
    let ty_old = type_of instr in
    let rec loop () =
      let ty = AUtil.choose_random !Config.interesting_types in
      if ty_old = ty then loop () else ty
    in
    let ty_new = loop () in
    Logger.debug "ty_old: %s, ty_new: %s@." (string_of_lltype ty_old)
      (string_of_lltype ty_new);

    (* Ensure each llvalue has its own name.
       This is necessary because we will use value names as key *)
    reset_var_names f;
    match collect_ty_changing_llvs instr ty_new (Some LLVMap.empty) with
    | None -> None
    | Some typemap ->
        let f_new = redef_fn llctx f typemap in
        verify_and_clean f f_new

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

let cut_below llctx instr =
  let open Util in
  let f_old = ALlvm.get_function instr in
  let instrs = ALlvm.fold_left_all_instr (fun accu i -> i :: accu) [] f_old in

  match instrs with
  | [] | [ _ ] | [ _; _ ] -> None
  | _ -> (
      (* target: new instruction will returned.*)
      let target = ALlvm.get_instr_before ~wide:true instr in
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
          let f_new = ALlvm.clone_function f_old new_ret_ty in

          ALlvm.delete_function f_old;

          (* Debug *)
          ALlvm.get_return_instr f_new
      | _ -> None)

(* ACTUAL MUTATION FUNCTIONS *)
(* CAUTION: THESE FUNCTIONS DIRECTLY MODIFIES GIVEN LLVM MODULE. *)

(* inner-basicblock mutation (independent of block CFG) *)
let rec mutate_inner_bb llctx mode llm score =
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in
  let instr_tgt = AUtil.choose_random all_instrs in
  (* depending on mode, available mutations differ *)
  let mutation = choose_mutation mode score in
  L.info "mutation: %a" pp_mutation mutation;
  L.debug "target: %s" (string_of_llvalue instr_tgt);
  L.debug "module: %s" (string_of_llmodule llm);
  let mutation_result =
    match mutation with
    | CREATE -> create_rand_instr llctx None instr_tgt
    | OPCODE -> subst_rand_instr llctx instr_tgt
    | OPERAND -> subst_rand_opd llctx None instr_tgt
    | FLAG -> modify_flag llctx instr_tgt
    | TYPE -> change_type llctx instr_tgt
    | CUT -> cut_below llctx instr_tgt
  in
  match mutation_result with
  | Some _ ->
      L.debug "mutant: %s" (string_of_llmodule llm);
      llm
  | None -> mutate_inner_bb llctx mode llm score

(* CFG-related mutation *)
(* let mutate_CFG = Fun.id *)

(* let subst_ret llctx instr =
     let f_old = instr |> get_function in
     reset_var_names f_old;
     let params_old = params f_old in
     let param_tys = Array.map type_of params_old in
     let old_ret_ty = instr |> type_of in
     let target = get_instr_before ~wide:true instr in
     match target with
     | Some i ->
         let new_ret_ty = type_of i in
         if old_ret_ty = new_ret_ty then (
           let _ = build_ret i (builder_before llctx instr) in
           delete_instruction instr;
           true)
         else
           let f_new =
             define_function ""
               (function_type new_ret_ty param_tys)
               (global_parent f_old)
           in
           params f_new
           |> Array.iteri (fun i param_new ->
                  set_value_name (value_name params_old.(i)) param_new);
           copy_function_with_new_retval llctx f_old f_new new_ret_ty;
           true
     | None -> true

   let check_retval llctx llm =
     let deleted_functions =
       fold_left_functions
         (fun acc f ->
           let res =
             fold_left_all_instr
               (fun res instr ->
                 if res then res
                 else
                   match instr_opcode instr with
                   | Call -> if is_llvm_intrinsic instr then res else true
                   | Ret -> (
                       match classify_value (operand instr 0) with
                       | ValueKind.ConstantInt | ConstantPointerNull | ConstantFP
                       | NullValue | Function ->
                           subst_ret llctx instr
                       | _ -> (
                           let ret_ty = operand instr 0 |> type_of in
                           match classify_type ret_ty with
                           | TypeKind.Void -> subst_ret llctx instr
                           | _ -> false))
                   | _ -> false)
               false f
           in
           if res then f :: acc else acc)
         [] llm
     in
     List.iter (fun f -> delete_function f) (List.rev deleted_functions);
     try
       let _ = choose_function llm in
       Some llm
     with _ -> None *)

(* TODO: add fuzzing configuration *)
let run llctx (seed : Seedcorpus.Seedpool.seed_t) =
  let mode = if seed.covers then FOCUS else EXPAND in
  let llm_clone = Llvm_transform_utils.clone_module seed.llm in
  mutate_inner_bb llctx mode llm_clone (int_of_float seed.score)
(* |> mutate_CFG |> check_retval llctx *)
