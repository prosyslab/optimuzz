open Util.ALlvm
module AUtil = Util.AUtil
module OpCls = OpcodeClass

type mode_t = EXPAND | FOCUS
type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE

let pp_mutation fmt m =
  match m with
  | CREATE -> Format.fprintf fmt "CREATE"
  | OPCODE -> Format.fprintf fmt "OPCODE"
  | OPERAND -> Format.fprintf fmt "OPERAND"
  | FLAG -> Format.fprintf fmt "FLAG"
  | TYPE -> Format.fprintf fmt "TYPE"

(* choose mutation *)
let choose_mutation mode score =
  match mode with
  | EXPAND ->
      let mutations =
        [| CREATE; CREATE; OPCODE; OPCODE; OPERAND; OPERAND; FLAG; FLAG; TYPE |]
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
let rec create_rand_instr llctx preferred_opd loc =
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
  | CAST when is_integer -> (
      try
        let dest_ty =
          match opcode with
          | Trunc -> TypeBW.random_narrower_llint llctx operand_ty
          | ZExt | SExt -> TypeBW.random_wider_llint llctx operand_ty
          | _ -> failwith "NEVER OCCUR"
        in
        create_cast llctx loc opcode operand dest_ty |> Option.some
      with TypeBW.Unsupported_Type ->
        create_rand_instr llctx preferred_opd loc)
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
      match instr |> instr_opcode |> OpCls.classify with
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

let is_there_hard_op f =
  fold_left_all_instr
    (fun accu i ->
      accu
      ||
      match i |> instr_opcode |> OpCls.classify with
      | OTHER -> true
      | _ -> false)
    false f

let is_mistargeting llv =
  match llv |> type_of |> classify_type with
  | TypeKind.Integer | Vector -> (
      match classify_value llv with
      | Instruction opc -> (
          match OpCls.classify opc with BINARY -> false | _ -> true)
      | Argument -> false
      | _ -> true)
  | _ -> true

(** [change_type llctx ty_new instr] changes type of [instr] randomly.
    All the other associated values are recursively changed.
    Returns [Some(instr)] if success, or [None] else. *)
let change_type llctx instr =
  (* llv is instruction now *)
  let f = get_function instr in

  (* target: select actual llvalue to change type *)
  let target =
    if num_operands instr > 0 then
      AUtil.choose_random
        (let rec loop accu i =
           if i >= num_operands instr then accu
           else loop (operand instr i :: accu) (i + 1)
         in
         loop [ instr ] 0)
    else instr
  in

  if is_there_hard_op f || is_mistargeting target then None
  else
    (* decide type *)
    let ty_old = type_of target in
    let ty_old2 = type_of instr in
    let rec loop () =
      let ty = AUtil.choose_random !Config.interesting_types in
      if ty_old = ty || ty_old2 = ty then loop () else ty
    in
    let ty_new = loop () in

    (* prevent anonymous llvalues (internally they are "")
       This is necessary because we will use value names as key for LLVMap *)
    reset_var_names f;

    (* infer types, types not inferred are regarded as the same *)
    let typemap = infer_types llctx ty_new target LLVMap.empty in
    let typemap =
      fold_left_all_instr
        (fun typemap instr_old ->
          if
            LLVMap.mem instr_old typemap
            || instr_old |> type_of |> classify_type = Void
          then typemap
          else LLVMap.add instr_old (type_of instr_old) typemap)
        typemap f
    in
    let typemap =
      Array.fold_left
        (fun typemap param_old ->
          if LLVMap.mem param_old typemap then typemap
          else LLVMap.add param_old (type_of param_old) typemap)
        typemap (params f)
    in

    (* re-define new (empty) function and migrate instructions *)
    let f_new, link = redef_fn llctx f typemap in

    (* Sometimes to change type is impossible.
       E.g., %0 = icmp eq i32 %x, %y; %1 = and i1 %0, %z.
       if so, ignore this mutation. *)
    if Llvm_analysis.verify_function f_new then (
      delete_function f;
      Some (LLVMap.find target link))
    else (
      delete_function f_new;
      None)

(* ACTUAL MUTATION FUNCTIONS *)
(* CAUTION: THESE FUNCTIONS DIRECTLY MODIFIES GIVEN LLVM MODULE. *)

(* inner-basicblock mutation (independent of block CFG) *)
let rec mutate_inner_bb llctx mode llm score =
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in
  let instr_tgt = AUtil.choose_random all_instrs in
  (* depending on mode, available mutations differ *)
  let mutation = choose_mutation mode score in
  if !Config.logging then AUtil.log "[mutation] %a\n" pp_mutation mutation;
  let mutation_result =
    match mutation with
    | CREATE -> create_rand_instr llctx None instr_tgt
    | OPCODE -> subst_rand_instr llctx instr_tgt
    | OPERAND -> subst_rand_opd llctx None instr_tgt
    | FLAG -> modify_flag llctx instr_tgt
    | TYPE -> change_type llctx instr_tgt
  in
  match mutation_result with
  | Some _ -> llm
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
