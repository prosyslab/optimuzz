open Util
open Util.ALlvm
module AUtil = Util.AUtil
module OpCls = OpcodeClass
module L = Logger

type opcode_t =
  | ICMP of ALlvm.Icmp.t
  | FCMP of ALlvm.Fcmp.t
  | OTHER of ALlvm.Opcode.t

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

let mutation_of_string s =
  match s with
  | "CREATE" -> CREATE
  | "OPCODE" -> OPCODE
  | "OPERAND" -> OPERAND
  | "FLAG" -> FLAG
  | "TYPE" -> TYPE
  | "CUT" -> CUT
  | _ -> failwith "Unreachable"

let uniform_mutations =
  [ (CREATE, 1); (OPCODE, 1); (OPERAND, 1); (FLAG, 1); (TYPE, 1); (CUT, 1) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let expand_mutations =
  [ (CREATE, 2); (OPCODE, 4); (OPERAND, 4); (FLAG, 3); (TYPE, 2); (CUT, 1) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let focus_mutations =
  [ (OPCODE, 3); (OPERAND, 3); (FLAG, 1); (TYPE, 2) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let pp_opcode fmt opc =
  match opc with
  | ICMP pred -> Format.fprintf fmt "ICmp %s" (ALlvm.string_of_icmp pred)
  | FCMP pred -> Format.fprintf fmt "FCmp %s" (ALlvm.string_of_fcmp pred)
  | OTHER opc -> Format.fprintf fmt "%s" (ALlvm.string_of_opcode opc)

let get_icmp opc =
  match opc with ICMP pred -> pred | _ -> failwith "opdoce_t is not ICMP"

let get_fcmp opc =
  match opc with FCMP pred -> pred | _ -> failwith "opdoce_t is not ICMP"

let get_other opc =
  match opc with
  | OTHER opc_new -> opc_new
  | _ -> failwith "opdoce_t is not OTHER"

(* create_[CLASS] llctx loc [args]+ creates corresponding instruction,
   right before instruction [loc], without any extra keywords.
   Returns the new instruction. *)

let create_binary llctx loc opcode o0 o1 =
  (OpCls.build_binary opcode) o0 o1 (builder_before llctx loc)

let create_fbinary llctx loc opcode o0 o1 =
  (OpCls.build_fbinary opcode) o0 o1 (builder_before llctx loc)

let create_cast llctx loc opcode o ty =
  (OpCls.build_cast opcode) o ty (builder_before llctx loc)

let create_icmp llctx loc pred o0 o1 =
  (OpCls.build_icmp pred) o0 o1 (builder_before llctx loc)

let create_fcmp llctx loc pred o0 o1 =
  (OpCls.build_fcmp pred) o0 o1 (builder_before llctx loc)

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

let fbinary_exchange_operands llctx instr =
  assert (OpCls.opcls_of instr = FBINARY);
  let left = operand instr 0 in
  let right = operand instr 1 in
  let loc = instr in
  let new_instr = create_fbinary llctx loc (instr_opcode instr) right left in
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

let subst_fbinary llctx instr opcode =
  let left = operand instr 0 in
  let right = operand instr 1 in
  let new_instr = create_fbinary llctx instr opcode left right in
  replace_hard instr new_instr;
  new_instr

let subst_cast llctx instr opc_new =
  assert (OpCls.opcls_of instr = CAST);
  (* ZExt -> SExt, SExt -> ZExt, Trunc -> Trunc (None), BitCast -> BitCast *)
  let new_instr =
    create_cast llctx instr opc_new (operand instr 0) (type_of instr)
  in
  replace_hard instr new_instr;
  new_instr

let subst_icmp llctx instr cond =
  let left = operand instr 0 in
  let right = operand instr 1 in
  let new_instr = create_icmp llctx instr cond left right in
  replace_hard instr new_instr;
  new_instr

let subst_fcmp llctx instr cond =
  let left = operand instr 0 in
  let right = operand instr 1 in
  let new_instr = create_fcmp llctx instr cond left right in
  replace_hard instr new_instr;
  new_instr

module Candidates = struct
  type t = {
    instr : llvalue list;
    param : llvalue list;
    const : llvalue list;
    global : llvalue list;
  }

  let is_empty cands = cands.instr = [] && cands.param = [] && cands.const = []
  let no_const cands = { cands with const = [] }
  let with_const const cands = { cands with const }
  let of_const const = { instr = []; param = []; const; global = [] }
  let const_of cands = cands.const

  let filter_each pred cands =
    let filter = List.filter pred in
    {
      instr = filter cands.instr;
      param = filter cands.param;
      const = filter cands.const;
      global = filter cands.global;
    }

  let flatten cands =
    cands.instr
    |> List.rev_append cands.param
    |> List.rev_append cands.const
    |> List.rev_append cands.global

  let choose cands =
    assert (not (is_empty cands));
    List.filter (( <> ) [])
      [ cands.const; cands.param; cands.instr; cands.global ]
    |> AUtil.choose_random
    |> AUtil.choose_random

  let pp cands =
    let print = List.iter (fun llv -> L.debug "%s" (string_of_llvalue llv)) in
    L.debug "candidates: ";
    print cands.instr;
    print cands.param;
    print cands.const;
    print cands.global
end

let unwrap_interest_int ty v =
  assert (classify_type ty = Integer);
  match v with
  | Config.Interests.Normal i -> const_int_of_string ty i 10
  | Undef -> undef ty
  | Poison -> poison ty
  | Float _ -> failwith "cannot unwrap floating point"
  | Intrinsic _ -> failwith "cannot unwrap Intrinsic"

let unwrap_interest_float ty v =
  assert (classify_type ty != Integer);
  match v with
  | Config.Interests.Float fl -> const_float ty fl
  | Undef -> undef ty
  | Poison -> poison ty
  | Normal _ -> failwith "cannot unwrap floating point"
  | Intrinsic _ -> failwith "cannot unwrap Intrinsic"

let unwrap_interest_vec ty v =
  assert (classify_type ty = Vector);
  if vector_size ty <> Array.length v then
    invalid_arg "cannot unwrap to unmatched size of vector."
  else
    let elty = element_type ty in
    v |> Array.map (unwrap_interest_int elty) |> const_vector

(** [get_rand_const ty] returns a random constant of type [ty]. *)
let get_rand_const ty =
  match classify_type ty with
  | Integer ->
      !Config.Interests.interesting_integers
      |> AUtil.choose_random
      |> unwrap_interest_int ty
  | Half | Float | Double | Fp128 ->
      !Config.Interests.interesting_floats
      |> AUtil.choose_random
      |> unwrap_interest_float ty
  | Vector ->
      let l =
        List.filter
          (fun v -> Array.length v = vector_size ty)
          !Config.Interests.interesting_vectors
      in

      if l = [] then
        let el_ty = element_type ty in
        let vec_size = vector_size ty in
        let llv =
          !Config.Interests.interesting_integers
          |> AUtil.choose_random
          |> unwrap_interest_int el_ty
        in
        const_vector (Array.make vec_size llv)
      else l |> AUtil.choose_random |> unwrap_interest_vec ty
  | Pointer -> const_null ty
  | _ -> failwith ("Unsupported type for get_rand_const: " ^ string_of_lltype ty)

(** [get_opd_cands loc ty] returns operand candidates of type [ty],
    valid at [loc]. *)
let get_opd_cands loc ty llm : Candidates.t =
  let cands_instr =
    loc
    |> get_instrs_before ~wide:false
    |> List.filter (fun v -> type_of v = ty)
  in
  let cands_const =
    match classify_type ty with
    | Integer ->
        List.map (unwrap_interest_int ty) !Config.Interests.interesting_integers
    | Half | Float | Double | Fp128 ->
        List.map (unwrap_interest_float ty) !Config.Interests.interesting_floats
    | Vector ->
        List.filter
          (fun v -> Array.length v = vector_size ty)
          !Config.Interests.interesting_vectors
        |> List.map (unwrap_interest_vec ty)
    | Pointer -> [ ty |> type_context |> pointer_type |> const_null ]
    | _ -> []
  in
  let cands_const =
    if instr_opcode loc = Store then
      List.filter (fun llv -> not (is_undef llv)) cands_const
    else cands_const
  in

  let cands_param =
    loc
    |> get_function
    |> fold_left_params
         (fun accu param -> if type_of param = ty then param :: accu else accu)
         []
  in
  let cands_global =
    fold_left_globals
      (fun accu llv -> if type_of llv = ty then llv :: accu else accu)
      [] llm
  in
  {
    instr = cands_instr;
    const = cands_const;
    param = cands_param;
    global = cands_global;
  }

(** [get_opd_cands_nonconst_ty loc] returns operand candidates valid at [loc].
    Returned candidates include non-const llvalues which have same type with [loc] *)
let get_opd_cands_nonconst_ty loc ty llm : Candidates.t =
  let tycls = ty |> classify_type in
  if tycls <> Void && tycls <> Pointer then
    let instrs =
      loc
      |> get_instrs_before ~wide:false
      |> List.filter (fun i -> type_of i = ty)
    in
    let params =
      loc
      |> get_function
      |> params
      |> Array.to_list
      |> List.filter (fun i -> type_of i = ty)
    in
    let globals =
      fold_left_globals
        (fun accu llv -> if type_of llv = ty then llv :: accu else accu)
        [] llm
    in
    { instr = instrs; param = params; const = []; global = globals }
  else { instr = []; param = []; const = []; global = [] }

(** [get_opd_cands_nonconst_allty loc] returns operand candidates valid at [loc].
    Returned candidates include non-const llvalues, regardless of types. *)
let get_opd_cands_nonconst_allty loc llm : Candidates.t =
  let instrs = loc |> get_instrs_before ~wide:false in
  let params = loc |> get_function |> params |> Array.to_list in
  let globals = fold_left_globals (fun accu llv -> llv :: accu) [] llm in
  { instr = instrs; param = params; const = []; global = globals }

(** @deprecated "NOT IMPLEMENTED" *)
let get_opd_cands_const_intty () = failwith "No need to implement"

(** @deprecated "NOT IMPLEMENTED" *)
let get_opd_cands_intty _loc = failwith "No need to implement"

(** [get_any_integer loc] returns all valid integers at [loc],
    regardless of types. *)
let get_any_integer loc llm =
  get_opd_cands_nonconst_allty loc llm
  |> Candidates.filter_each (fun v -> v |> type_of |> classify_type = Integer)
  |> Candidates.with_const
       [
         get_rand_const
           (AUtil.choose_random !Config.Interests.interesting_integer_types);
       ]
  |> Candidates.choose

(** [get_any_pointer loc] returns all valid pointers at [loc], *)
let get_any_pointer loc llm =
  get_opd_cands_nonconst_allty loc llm
  |> Candidates.filter_each (fun v -> v |> type_of |> classify_type = Pointer)
  |> Candidates.choose

(** [get_opd_cands_const_vecty ()] returns all constant vector operand
    candidates. *)
let get_opd_cands_const_vecty () =
  List.map
    (fun ty ->
      !Config.Interests.interesting_vectors
      |> List.filter (fun v -> vector_size ty = Array.length v)
      |> List.map (unwrap_interest_vec ty))
    !Config.Interests.interesting_vector_types
  |> List.flatten
  |> Candidates.of_const

(** [get_opd_cands_vecty loc] returns all vector typed operand candidates,
    valid at [loc]. *)
let get_opd_cands_vecty loc llm =
  get_opd_cands_nonconst_allty loc llm
  |> Candidates.filter_each (fun v -> v |> type_of |> classify_type = Vector)
  |> Candidates.with_const (get_opd_cands_const_vecty () |> Candidates.const_of)

(** [get_rand_opd llctx loc instr_old] gets, or generates
    a llvalue as an operand, of type of [instr_old], valid at [loc]. *)
let get_rand_opd loc ty llm = Candidates.choose (get_opd_cands loc ty llm)

(** [get_alternate loc instr_old] find an alternate value for [instr_old],
    valid at [loc].
    If result is equal to [instr_old], this will pick another one.
    Return is wrapped by [Option] to represent impossible cases. *)
let get_alternate loc ?(include_const = false) llv_old llm =
  let cands =
    get_opd_cands loc (type_of llv_old) llm
    |> (if include_const then Fun.id else Candidates.no_const)
    |> Candidates.filter_each (( <> ) llv_old)
  in
  if Candidates.is_empty cands then None else Some (Candidates.choose cands)

let not_void_or_ptr llv =
  let tycls = llv |> type_of |> classify_type in
  tycls <> Void && tycls <> Pointer

let check_cast_ty opc ty_dst llv =
  assert (OpCls.classify opc = CAST);
  let ty_src = type_of llv in
  let get_bw ty =
    let tycls = classify_type ty in
    assert (tycls = Integer || tycls = Vector);
    if tycls = Integer then integer_bitwidth ty
    else ty |> element_type |> integer_bitwidth
  in
  let get_total_bw ty =
    let tycls = classify_type ty in
    assert (tycls = Integer || tycls = Vector);
    if tycls = Integer then integer_bitwidth ty
    else
      let el_bw = ty |> element_type |> integer_bitwidth in
      el_bw * vector_size ty
  in
  match opc with
  | ZExt | SExt -> get_bw ty_dst > get_bw ty_src
  | Trunc -> get_bw ty_dst < get_bw ty_src
  | BitCast -> get_total_bw ty_dst = get_total_bw ty_src
  | _ -> failwith "NEVER OCCUR"

let get_dst_tys opc ty_src =
  assert (OpCls.classify opc = CAST);
  let tycls_src = classify_type ty_src in
  assert (tycls_src = Integer || tycls_src = Vector);

  let tys_whole =
    if tycls_src = Integer then !Config.Interests.interesting_integer_types
    else
      !Config.Interests.interesting_vector_types
      |> List.filter (fun t -> vector_size t = vector_size ty_src)
  in
  let bw =
    if tycls_src = Integer then integer_bitwidth
    else fun t -> t |> element_type |> integer_bitwidth
  in
  let pred = if opc = Trunc then ( < ) else ( > ) in
  List.filter (fun t -> pred (bw t) (bw ty_src)) tys_whole

let get_rand_integer_intrinsic llctx str loc ty_dst llm =
  if Random.bool () then
    match
      AUtil.choose_random
        !Config.Interests.interesting_binary_integer_intrinsics
    with
    | Config.Interests.Intrinsic fn ->
        let fn = fn ^ "." ^ str in
        let opd = get_rand_opd loc ty_dst llm in
        let opd' = get_rand_opd loc ty_dst llm in
        let param_types = [| type_of opd; type_of opd' |] in
        let fnty = function_type ty_dst param_types in
        let intrinsic = add_intrinsic_by_name llm fn fnty in
        build_call fnty intrinsic [| opd; opd' |] "" (builder_before llctx loc)
    | _ -> failwith "Not Intrinsic"
  else
    match
      AUtil.choose_random !Config.Interests.interesting_unary_integer_intrinsics
    with
    | Config.Interests.Intrinsic fn ->
        let fn = fn ^ "." ^ str in
        let opd = get_rand_opd loc ty_dst llm in
        let param_types = [| type_of opd |] in
        let fnty = function_type ty_dst param_types in
        let intrinsic = add_intrinsic_by_name llm fn fnty in
        build_call fnty intrinsic [| opd |] "" (builder_before llctx loc)
    | _ -> failwith "Not Intrinsic"

let get_rand_float_intrinsic llctx str loc ty_dst llm =
  if Random.bool () then
    match
      AUtil.choose_random !Config.Interests.interesting_binary_float_intrinsics
    with
    | Config.Interests.Intrinsic fn ->
        let fn = fn ^ "." ^ str in
        let opd = get_rand_opd loc ty_dst llm in
        let opd' = get_rand_opd loc ty_dst llm in
        let param_types = [| type_of opd; type_of opd' |] in
        let fnty = function_type ty_dst param_types in
        let intrinsic = add_intrinsic_by_name llm fn fnty in
        build_call fnty intrinsic [| opd; opd' |] "" (builder_before llctx loc)
    | _ -> failwith "Not Intrinsic"
  else
    match
      AUtil.choose_random !Config.Interests.interesting_unary_float_intrinsics
    with
    | Config.Interests.Intrinsic fn ->
        let fn = fn ^ "." ^ str in
        let opd = get_rand_opd loc ty_dst llm in
        let param_types = [| type_of opd |] in
        let fnty = function_type ty_dst param_types in
        let intrinsic = add_intrinsic_by_name llm fn fnty in
        build_call fnty intrinsic [| opd |] "" (builder_before llctx loc)
    | _ -> failwith "Not Intrinsic"

let create_rand_instrinsic_by_ty llctx loc idx ty_dst llm =
  match classify_type ty_dst with
  | Integer ->
      let bw = integer_bitwidth ty_dst in
      let new_instr =
        get_rand_integer_intrinsic llctx (string_of_int bw) loc ty_dst llm
      in
      set_operand loc idx new_instr;
      ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm)
  | Half ->
      let new_instr = get_rand_float_intrinsic llctx "f16" loc ty_dst llm in
      set_operand loc idx new_instr;
      ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm)
  | Float ->
      let new_instr = get_rand_float_intrinsic llctx "f32" loc ty_dst llm in
      set_operand loc idx new_instr;
      ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm)
  | Double ->
      let new_instr = get_rand_float_intrinsic llctx "f64" loc ty_dst llm in
      set_operand loc idx new_instr;
      ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm)
  | Fp128 ->
      let new_instr = get_rand_float_intrinsic llctx "f128" loc ty_dst llm in
      set_operand loc idx new_instr;
      ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm)
  | Vector -> ([], None (* TODO*))
  | _ -> ([], None)

(* %0 = extractelement %VEC, %opd *)
let create_rand_extractelement_int llctx loc opd llm =
  let builder = builder_before llctx loc in
  assert (opd |> type_of |> classify_type = Integer);
  let cands_vec = get_opd_cands_vecty loc llm in
  assert (not (Candidates.is_empty cands_vec));
  let vec = Candidates.choose cands_vec in
  build_extractelement vec opd "" builder

(* %0 = extractelement %opd, %IDX *)
let create_rand_extractelement_vec llctx loc opd llm =
  let builder = builder_before llctx loc in
  assert (opd |> type_of |> classify_type = Vector);
  let idx = get_any_integer loc llm in
  build_extractelement opd idx "" builder

(* result = extractelement <n x <ty>> val, <ty2> idx *)
let create_rand_extractelement llctx loc opd =
  assert (match classify_value loc with Instruction _ -> true | _ -> false);
  assert (not (is_constant opd));

  match opd |> type_of |> classify_type with
  | Integer -> create_rand_extractelement_int llctx loc opd
  | Vector -> create_rand_extractelement_vec llctx loc opd
  | _ ->
      failwith
        ("Assertion failure! opd of create_rand_extractelement must be an \
          integer or a vector, given: "
        ^ string_of_llvalue opd)

let create_rand_insertelement_int llctx loc opd llm =
  let builder = builder_before llctx loc in
  let cands_vec = get_opd_cands_vecty loc llm in
  let cands_vec_same_ty =
    Candidates.filter_each
      (fun v -> v |> type_of |> element_type = type_of opd)
      cands_vec
  in
  if Candidates.is_empty cands_vec_same_ty || AUtil.rand_bool () then
    (* use opd as index *)
    let vec = Candidates.choose cands_vec in
    let el_ty = vec |> type_of |> element_type in
    let el = get_rand_opd loc el_ty llm in
    build_insertelement vec el opd "" builder
  else
    (* use opd as inserted value *)
    let vec = Candidates.choose cands_vec_same_ty in
    let idx = get_any_integer loc llm in
    build_insertelement vec opd idx "" builder

let create_rand_insertelement_vec llctx loc opd llm =
  let builder = builder_before llctx loc in
  let el_ty = opd |> type_of |> element_type in
  let el = get_rand_opd loc el_ty llm in
  let idx = get_any_integer loc llm in
  build_insertelement opd el idx "" builder

(* result = insertelement <n x <ty>> val, <ty> el, <ty2> idx *)
let create_rand_insertelement llctx loc opd =
  assert (match classify_value loc with Instruction _ -> true | _ -> false);
  assert (not (is_constant opd));
  match opd |> type_of |> classify_type with
  | Integer -> create_rand_insertelement_int llctx loc opd
  | Vector -> create_rand_insertelement_vec llctx loc opd
  | _ ->
      failwith
        ("Assertion failure! opd of create_rand_insertelement must be an \
          integer or a vector, given: "
        ^ string_of_llvalue opd)

(* result = shufflevector <n x <ty>> v1, <n x <ty>> v2, <m x i32> mask
   ; mask must be constant
   ; yields <m x <ty>> *)
let create_rand_shufflevector llctx loc opd llm =
  assert (match classify_value loc with Instruction _ -> true | _ -> false);
  assert (not (is_constant opd));
  let builder = builder_before llctx loc in
  let ty_opd = type_of opd in
  let tycls_opd = classify_type ty_opd in
  assert (tycls_opd = Vector);

  (* use opd as one of input vectors *)
  let opd' = get_rand_opd loc ty_opd llm in
  let mask =
    let cands_mask =
      get_opd_cands_const_vecty ()
      |> Candidates.const_of
      |> List.filter (fun v ->
             v |> type_of |> element_type |> integer_bitwidth = 32)
    in
    (* constants must exist *)
    assert (cands_mask <> []);
    AUtil.choose_random cands_mask
  in
  build_shufflevector opd opd' mask "" builder

(* result = select <selty> cond, <ty> val1, <ty> val2 *)
let create_rand_select llctx loc opd llm =
  assert (match classify_value loc with Instruction _ -> true | _ -> false);
  assert (not (is_constant opd));
  let builder = builder_before llctx loc in
  let ty_opd = type_of opd in
  let tycls_opd = classify_type ty_opd in

  (* assert (tycls_opd = Integer || tycls_opd = Vector); *)

  (* if opd is i1 or <n x i1>, it can be used as condition *)
  let use_opd_as_cond =
    AUtil.rand_bool ()
    && ((tycls_opd = Integer && integer_bitwidth ty_opd = 1)
       || (tycls_opd = Vector && integer_bitwidth (element_type ty_opd) = 1))
  in

  (* cond, t/f value must have same size (if vector) *)
  let llvs_same_size =
    get_opd_cands_nonconst_allty loc llm
    |> Candidates.flatten
    |> List.filter (fun v ->
           let ty_v = type_of v in
           match (tycls_opd, classify_type ty_v) with
           | Vector, Vector -> vector_size ty_opd = vector_size ty_v
           | ty1, ty2 -> ty1 = ty2)
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
      if tycls_opd = Vector then
        vector_type (i1_type llctx) (vector_size ty_opd)
      else i1_type llctx
    in
    let llvs_i1 = List.filter (fun v -> type_of v = ty_i1) llvs_same_size in
    let cond =
      if llvs_i1 = [] then get_rand_const ty_i1 else AUtil.choose_random llvs_i1
    in
    build_select cond opd opd' "" builder

let rec get_cands_for_create loc i cands llm =
  if i = num_operands loc then cands
  else if i |> operand loc |> type_of |> classify_type == Pointer then
    get_cands_for_create loc (i + 1) cands llm
  else
    let dst = operand loc i in
    let dst_ty = type_of dst in
    let opc =
      (match classify_type dst_ty with
      | Vector ->
          List.flatten
            [
              [ Opcode.ICmp; Select ];
              Array.to_list OpCls.binary_arr;
              Array.to_list OpCls.vec_arr;
              Array.to_list OpCls.cast_arr;
            ]
      | Integer ->
          List.flatten
            [
              [ Opcode.ICmp; Select ];
              Array.to_list OpCls.binary_arr;
              Array.to_list OpCls.cast_arr;
            ]
      | Half | Float | Double | Fp128 ->
          List.flatten [ [ Opcode.Select ]; Array.to_list OpCls.fbinary_arr ]
      | _ -> failwith "unsupported type for create llv")
      |> AUtil.choose_random
    in
    let opds =
      match OpCls.classify opc with
      | ICMP ->
          get_opd_cands_nonconst_allty loc llm
          |> Candidates.filter_each not_void_or_ptr
      | CAST ->
          get_opd_cands_nonconst_allty loc llm
          |> Candidates.filter_each not_void_or_ptr
          |> Candidates.filter_each (check_cast_ty opc dst_ty)
      | _ ->
          get_opd_cands_nonconst_ty loc dst_ty llm
          |> Candidates.filter_each not_void_or_ptr
    in
    let cands =
      if Candidates.is_empty opds then cands else (i, opc, opds) :: cands
    in
    get_cands_for_create loc (i + 1) cands llm

(** [create_rand_llv llctx llm] creates a random instruction or gloabl variable. *)
let create_rand_llv llctx importants llm =
  if Random.int 8 = 0 then
    let ty = AUtil.choose_random !Config.Interests.interesting_types in
    let new_global = declare_global ty "" llm in
    ([ string_of_llvalue new_global ], Some llm)
  else
    let llm = Llvm_transform_utils.clone_module llm in
    let f = choose_function llm in
    let all_instrs =
      fold_left_all_instr (fun accu instr -> instr :: accu) [] f
    in
    let importants_instrs =
      all_instrs
      |> List.filter (fun instr ->
             List.mem (string_of_llvalue instr) importants)
      |> List.filter (fun i ->
             let opc = instr_opcode i in
             opc <> PHI && opc <> Call && opc <> Br)
    in
    let loc =
      if importants_instrs <> [] && Random.int 3 = 0 then
        AUtil.choose_random importants_instrs
      else
        all_instrs
        |> List.filter (fun i ->
               let opc = instr_opcode i in
               opc <> PHI && opc <> Call && opc <> Br)
        |> AUtil.choose_random
    in
    L.debug "location: %s" (string_of_llvalue loc);
    match Random.int 15 with
    | 0 ->
        (* Create intrinsic instruction *)
        let idx = loc |> num_operands |> Random.int in
        let dst = operand loc idx in
        let ty_dst = type_of dst in
        create_rand_instrinsic_by_ty llctx loc idx ty_dst llm
    | 1 | 2 | 3 ->
        (* Create store instruction *)
        let opd = get_opd_cands_nonconst_allty loc llm |> Candidates.choose in
        let ptr = get_any_pointer loc llm in
        let new_instr = build_store opd ptr (builder_before llctx loc) in
        ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm)
    | _ ->
        let cands = get_cands_for_create loc 0 [] llm in
        if cands = [] then ([], None)
        else
          let idx, opc, opds = AUtil.choose_random cands in
          L.debug "idx: %s" (string_of_int idx);
          L.debug "opcode: %s" (string_of_opcode opc);
          let opd = Candidates.choose opds in
          L.debug "operand: %s" (string_of_llvalue opd);
          let ty_dst = type_of (operand loc idx) in
          let ty_opd = type_of opd in
          let new_instr =
            match OpCls.classify opc with
            | BINARY ->
                let opd' = get_rand_opd loc ty_opd llm in
                create_binary llctx loc opc opd opd'
            | FBINARY ->
                let opd' = get_rand_opd loc ty_opd llm in
                create_fbinary llctx loc opc opd opd'
            | VEC ExtractElement -> create_rand_extractelement llctx loc opd llm
            | VEC InsertElement -> create_rand_insertelement llctx loc opd llm
            | VEC ShuffleVector ->
                if opd |> type_of |> classify_type = Vector then
                  create_rand_shufflevector llctx loc opd llm
                else (
                  L.debug
                    "ShuffleVector instruction does not require non-vector \
                     operands.";
                  L.debug "This mutation will be ignored.";
                  loc)
            | CAST -> create_cast llctx loc opc opd ty_dst
            | ICMP ->
                let cond = OpCls.random_icmp () in
                let opd' = get_rand_opd loc ty_opd llm in
                create_icmp llctx loc cond opd opd'
            | FCMP ->
                let cond = OpCls.random_fcmp () in
                let opd' = get_rand_opd loc ty_opd llm in
                create_fcmp llctx loc cond opd opd'
            | OTHER Select -> create_rand_select llctx loc opd llm
            | _ -> failwith "NEVER OCCUR"
          in
          if type_of new_instr == ty_dst then (
            set_operand loc idx new_instr;
            ([ string_of_llvalue new_instr; string_of_llvalue loc ], Some llm))
          else ([], None)

(** [subst_rand_instr llctx learning opc_tbl llm] substitutes a random instruction into another
      random instruction of the same [OpCls.t], with the same operands.
      Note: flags are not preserved. *)
let subst_rand_instr llctx importants llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in

  (* choose target instruction, possible opcls are:
     BINARY, CAST(Ext), ICMP *)
  let is_tgt i =
    match OpCls.opcls_of i with
    | BINARY -> true
    | FBINARY -> true
    | CAST -> instr_opcode i <> Trunc && instr_opcode i <> BitCast
    | ICMP -> true
    | FCMP -> true
    | _ -> false
  in
  let cands_instr = List.filter is_tgt all_instrs in
  let importants_instrs =
    cands_instr
    |> List.filter (fun instr -> List.mem (string_of_llvalue instr) importants)
  in
  if cands_instr = [] then ([], None)
  else
    let instr =
      if importants_instrs <> [] && Random.int 3 = 0 then
        AUtil.choose_random importants_instrs
      else AUtil.choose_random cands_instr
    in
    L.debug "instr: %s" (string_of_llvalue instr);
    let opc_old = instr_opcode instr in
    match OpCls.classify opc_old with
    | BINARY ->
        let opc_new = OpCls.random_binary_except opc_old in
        if opc_old = opc_new then ([], None)
        else (
          L.debug "opc_new: %s" (string_of_opcode opc_new);
          let new_instr = subst_binary llctx instr opc_new in
          ( string_of_llvalue new_instr :: get_all_user_str_llv new_instr,
            Some llm ))
    | FBINARY ->
        let opc_new = OpCls.random_fbinary_except opc_old in
        if opc_old = opc_new then ([], None)
        else (
          L.debug "opc_new: %s" (string_of_opcode opc_new);
          let new_instr = subst_fbinary llctx instr opc_new in
          ( string_of_llvalue new_instr :: get_all_user_str_llv new_instr,
            Some llm ))
    | CAST ->
        let opc_new =
          match opc_old with
          | ZExt -> Opcode.SExt
          | SExt -> ZExt
          | Trunc -> Trunc
          | BitCast -> BitCast
          | _ -> failwith "NEVER OCCUR"
        in
        if opc_old = opc_new then ([], None)
        else
          let new_instr = subst_cast llctx instr opc_new in
          ( string_of_llvalue new_instr :: get_all_user_str_llv new_instr,
            Some llm )
    | ICMP ->
        let pred_old = icmp_predicate instr |> Option.get in
        let pred_new = OpCls.random_icmp_except pred_old in
        if pred_old = pred_new then ([], None)
        else
          let new_instr = subst_icmp llctx instr pred_new in
          ( string_of_llvalue new_instr :: get_all_user_str_llv new_instr,
            Some llm )
    | FCMP ->
        let pred_old = fcmp_predicate instr |> Option.get in
        let pred_new = OpCls.random_fcmp_except pred_old in
        if pred_old = pred_new then ([], None)
        else
          let new_instr = subst_fcmp llctx instr pred_new in
          ( string_of_llvalue new_instr :: get_all_user_str_llv new_instr,
            Some llm )
    | _ -> failwith "NEVER OCCUR"

let count_const_opds instr =
  let rec loop accu i =
    if i >= num_operands instr then accu
    else loop (accu + if is_constant (operand instr i) then 1 else 0) (i + 1)
  in
  loop 0 0

let invest_opd_alts instr llm =
  let num_opds = num_operands instr in
  let cnt = count_const_opds instr in
  (* TODO: below assertion is broken due to alloca.
     assert (num_opds = 0 || cnt < num_opds); *)
  let can_be_const opd = if cnt + 1 = num_opds then is_constant opd else true in

  let rec loop accu i =
    if i >= num_opds then accu
    else
      let opd = operand instr i in
      match get_alternate instr ~include_const:(can_be_const opd) opd llm with
      | None -> loop accu (i + 1)
      | Some alt -> loop ((i, alt) :: accu) (i + 1)
  in
  loop [] 0

(** [subst_rand_opd llctx llm] substitutes an operand of an instruction into
    another available one, randomly. *)
let subst_rand_opd llctx importants llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in

  (* choose target instruction, possible opcls are:
     BINARY, FBINARY, CAST(Ext), ICMP *)
  let cands =
    all_instrs
    |> List.map (fun instr -> (instr, invest_opd_alts instr llm))
    |> List.filter (fun (_, alts) -> alts <> [])
  in
  let importants_cands =
    cands
    |> List.filter (fun (instr, _) ->
           List.mem (string_of_llvalue instr) importants)
  in
  if cands = [] then ([], None)
  else
    let instr, alts =
      if importants_cands <> [] && Random.int 3 = 0 then
        AUtil.choose_random importants_cands
      else AUtil.choose_random cands
    in
    L.debug "instr: %s" (string_of_llvalue instr);
    if is_noncommutative_binary instr && AUtil.rand_bool () then (
      L.debug "exchange two operands";
      let new_instr =
        match instr |> instr_opcode |> OpcodeClass.classify with
        | BINARY -> binary_exchange_operands llctx instr
        | FBINARY -> binary_exchange_operands llctx instr
        | _ -> failwith "opcode is not binary or fbinary"
      in
      ([ string_of_llvalue new_instr ], Some llm))
    else
      let alt = AUtil.choose_random alts in
      L.debug "substitute operand %d to %s" (fst alt)
        (string_of_llvalue (snd alt));
      set_operand instr (fst alt) (snd alt);
      ([ string_of_llvalue (snd alt); string_of_llvalue instr ], Some llm)

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
  set_nsw nsw_new instr;
  instr

let edit_be_exact instr =
  let open Flag in
  assert (instr |> instr_opcode |> can_be_exact);
  set_exact (not (is_exact instr)) instr;
  instr

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
  | [], [] -> ([], None)
  | _, [] ->
      let new_instr = instrs_overflow |> AUtil.choose_random |> edit_overflow in
      ([ string_of_llvalue new_instr ], ret)
  | [], _ ->
      let new_instr = instrs_be_exact |> AUtil.choose_random |> edit_be_exact in
      ([ string_of_llvalue new_instr ], ret)
  | _ ->
      let i =
        instrs_overflow
        |> List.rev_append instrs_be_exact
        |> AUtil.choose_random
      in
      (* no opcode can be both *)
      let new_instr =
        if can_overflow i then edit_overflow i else edit_be_exact i
      in
      ([ string_of_llvalue new_instr ], ret)

type collect_ty_res_t = Impossible | Retry | Success of lltype LLVMap.t

let rec check_const_flow llv res =
  if res then res
  else
    match classify_value llv with
    | Instruction ICmp -> true
    | Instruction FCmp -> true
    | Instruction _ ->
        let opd_num = num_operands llv in
        let rec aux i res =
          if i = opd_num || res then res
          else
            let res = check_const_flow (operand llv i) res in
            aux (i + 1) res
        in
        aux 0 res
    | _ -> false

(* CAST instructions directly affects to types, need special caring *)
let rec trav_cast llv ty_new accu =
  match classify_value llv with
  | Instruction opc
    when OpcodeClass.classify opc = CAST && operand llv 0 |> type_of = ty_new ->
      if check_const_flow (operand llv 0) false then accu
      else if opc = BitCast then accu
      else Retry
  | _ when type_of llv = ty_new -> Retry
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
      | CAST when opc = BitCast ->
          if check_cast_ty opc ty_new curr then accu else Retry
      | CAST -> trav_cast (operand curr 0) ty_new accu
      | BINARY | FBINARY ->
          let opd0 = operand curr 0 in
          let opd1 = operand curr 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 ty_new
      | VEC ExtractElement ->
          let opd0 = operand curr 0 in
          collect_ty_changing_llvs opd0
            (vector_type ty_new (opd0 |> type_of |> vector_size))
            accu
      | VEC InsertElement ->
          let opd0 = operand curr 0 in
          let opd1 = operand curr 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 (element_type ty_new)
      | VEC ShuffleVector ->
          (* mask is surely constant, we can infer it later *)
          let opd0 = operand curr 0 in
          let opd1 = operand curr 1 in
          assert (type_of opd0 = type_of opd1);
          accu
          |> collect_ty_changing_llvs opd0
               (vector_type (element_type ty_new) (vector_size (type_of opd0)))
          |> collect_ty_changing_llvs opd1
               (vector_type (element_type ty_new) (vector_size (type_of opd0)))
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
    USING [curr] (users of curr).
    Handle exceptional cases:
    1. LHS type = RHS type <> user type (icmp, shufflevector)
    2. Certain operand position requires certain type class (vector instrs) *)
and trav_llvs_using_curr curr ty_new accu =
  let tycls = classify_type ty_new in
  fold_left_uses
    (fun accu use ->
      let user = user use in
      match OpCls.opcls_of user with
      | TER _ | MEM _ -> (* does not affect *) accu
      | CAST when classify_value user = Instruction BitCast ->
          if check_cast_ty BitCast ty_new user then
            collect_ty_changing_llvs user ty_new accu
          else Retry
      | CAST -> trav_cast user ty_new accu
      | BINARY | FBINARY | OTHER PHI ->
          collect_ty_changing_llvs user ty_new accu
      | OTHER Select ->
          let cond = operand user 0 in
          if cond = curr && ty_new <> type_of cond then Impossible
          else if user |> type_of |> classify_type = Pointer then Impossible
          else collect_ty_changing_llvs user ty_new accu
      | VEC ExtractElement ->
          if operand user 0 = curr then
            if tycls <> Vector then Impossible
            else collect_ty_changing_llvs user (element_type ty_new) accu
          else accu
      | VEC InsertElement ->
          if operand user 0 = curr then
            if tycls <> Vector then Impossible
            else collect_ty_changing_llvs user ty_new accu
          else if operand user 1 = curr then
            if tycls <> Integer then Impossible
            else
              collect_ty_changing_llvs user
                (vector_type ty_new (user |> type_of |> vector_size))
                accu
          else accu
      | VEC ShuffleVector ->
          if tycls <> Vector then Impossible
          else
            (* preserve type equality of both operands *)
            let opd0 = operand user 0 in
            let opd1 = operand user 1 in
            accu
            |> collect_ty_changing_llvs
                 (if opd0 = curr then opd1 else opd0)
                 ty_new
            |> collect_ty_changing_llvs user
                 (vector_type (element_type ty_new)
                    (user |> type_of |> vector_size))
      | ICMP ->
          (* preserve type equality of both operands *)
          let opd0 = operand user 0 in
          let opd1 = operand user 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 ty_new
          |> trav_llvs_using_curr user (type_of user)
      | FCMP ->
          (* preserve type equality of both operands *)
          let opd0 = operand user 0 in
          let opd1 = operand user 1 in
          accu
          |> collect_ty_changing_llvs opd0 ty_new
          |> collect_ty_changing_llvs opd1 ty_new
          |> trav_llvs_using_curr user (type_of user)
      | _ -> failwith "NEVER OCCUR")
    accu curr

(** [collect_ty_changing_llvs llv ty_new accu] recursively accumulates type
    information to [accu] when [llv] changes to [ty_new]. *)
and collect_ty_changing_llvs llv ty_new accu =
  match accu with
  | Success accu_inner when LLVMap.mem llv accu_inner -> accu
  | Success _ when is_constant llv -> accu
  | Success accu -> (
      let accu = LLVMap.add llv ty_new accu in
      match classify_value llv with
      | Instruction opc ->
          if opc = ICmp then Impossible
          else if opc = FCmp then Impossible
          else if opc = ExtractElement && classify_type ty_new <> Integer then
            Impossible
          else if opc = InsertElement && classify_type ty_new <> Vector then
            Impossible
          else if opc = ShuffleVector && classify_type ty_new <> Vector then
            Impossible
          else if opc = BitCast && not (check_cast_ty opc ty_new llv) then Retry
          else
            Success accu
            |> trav_llvs_used_by_curr llv ty_new
            |> trav_llvs_using_curr llv ty_new
      | Argument -> Success accu |> trav_llvs_using_curr llv ty_new
      | _ -> failwith "collect_ty: llv is none of instr, param, or const")
  | _ -> accu

let get_ty llv_old typemap =
  match LLVMap.find_opt llv_old typemap with
  | Some ty -> ty
  | None -> type_of llv_old

(** [move_signature f_old typemap] returns new signature of [f_old]
    according to [typemap]. *)
let move_signature f_old typemap =
  let ret_ty = get_return_type f_old in
  let param_tys = f_old |> params |> Array.map (Fun.flip get_ty typemap) in
  (ret_ty, param_tys)

let migrate_const_int llv_old ty_new =
  assert (is_constant llv_old);
  let ty_old = type_of llv_old in
  assert (classify_type ty_old = Integer);
  assert (classify_type ty_new = Integer);

  if is_undef llv_old then undef ty_new
  else if is_poison llv_old then poison ty_new
  else const_int_of_string ty_new (llv_old |> string_of_constint) 10

let migrate_const_float llv_old ty_new =
  assert (is_constant llv_old);
  if is_undef llv_old then undef ty_new
  else if is_poison llv_old then poison ty_new
  else
    match llv_old |> float_of_const with
    | Some fl -> const_float ty_new fl
    | None ->
        failwith
          (Printf.sprintf "Unsupported type migration (%s)"
             (string_of_llvalue llv_old))

let migrate_const llv_old ty_new =
  assert (is_constant llv_old);
  match (llv_old |> type_of |> classify_type, classify_type ty_new) with
  | Pointer, Pointer -> const_null ty_new
  | Integer, Integer -> migrate_const_int llv_old ty_new
  | ft1, ft2 when is_realtype ft1 && is_realtype ft2 ->
      migrate_const_float llv_old ty_new
  | Integer, Vector ->
      let el_ty = element_type ty_new in
      let vec_size = vector_size ty_new in
      let llv_arr = Array.make vec_size (migrate_const_int llv_old el_ty) in
      const_vector llv_arr
  | Vector, Integer ->
      migrate_const_int (aggregate_element llv_old 0 |> Option.get) ty_new
  | Vector, Vector ->
      let el_ty = element_type ty_new in
      let vec_size = vector_size ty_new in
      let llv_arr =
        Array.make vec_size
          (migrate_const_int (aggregate_element llv_old 0 |> Option.get) el_ty)
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

let migrate_fbinary builder instr_old typemap link_v =
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
  OpCls.build_fbinary opc opd0 opd1 builder

let migrate_extractelement builder instr_old link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  build_extractelement (migrate_self opd0 link_v) (migrate_self opd1 link_v) ""
    builder

let migrate_insertelement builder instr_old typemap link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let opd2 = operand instr_old 2 in

  let opd0 =
    match LLVMap.find_opt instr_old typemap with
    | Some ty_new -> migrate_to_other_ty opd0 ty_new link_v
    | None -> migrate_self opd0 link_v
  in
  build_insertelement opd0
    (migrate_to_other_ty opd1 (opd0 |> type_of |> element_type) link_v)
    (migrate_self opd2 link_v) "" builder

let migrate_shufflevector builder instr_old typemap link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let mask = get_shufflevector_mask instr_old in

  let ty_new = get_ty instr_old typemap in
  let mask_new =
    if ty_new = type_of instr_old then mask
    else
      migrate_const mask
        (vector_type (element_type (type_of mask)) (vector_size ty_new))
  in

  let opd0, opd1 =
    match (is_constant opd0, is_constant opd1) with
    | true, true -> failwith "Both operands of ShuffleVector are constants."
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
  build_shufflevector opd0 opd1 mask_new "" builder

let migrate_vec builder instr_old typemap link_v =
  let opc = instr_opcode instr_old in
  match opc with
  | ExtractElement -> migrate_extractelement builder instr_old link_v
  | InsertElement -> migrate_insertelement builder instr_old typemap link_v
  | ShuffleVector -> migrate_shufflevector builder instr_old typemap link_v
  | _ -> failwith "NEVER OCCUR"

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
    let get_bw ty =
      let tycls = classify_type ty in
      assert (tycls = Integer || tycls = Vector);
      if tycls = Integer then integer_bitwidth ty
      else ty |> element_type |> integer_bitwidth
    in
    get_bw dest_ty < (opd |> type_of |> get_bw)
  in
  (* FIXME: for now, using ZExt only *)
  (if instr_opcode instr_old = BitCast then build_bitcast
   else if is_trunc then build_trunc
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

let migrate_fcmp builder instr_old link_v =
  let opd0 = operand instr_old 0 in
  let opd1 = operand instr_old 1 in
  let build_fcmp o0 o1 =
    OpCls.build_fcmp (fcmp_predicate instr_old |> Option.get) o0 o1 builder
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
  build_fcmp opd0 opd1

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
    | FBINARY -> migrate_fbinary builder instr_old typemap link_v
    | VEC _ -> migrate_vec builder instr_old typemap link_v
    | MEM _ -> migrate_mem builder instr_old typemap link_v
    | CAST -> migrate_cast builder instr_old typemap link_v
    | ICMP -> migrate_icmp builder instr_old link_v
    | FCMP -> migrate_fcmp builder instr_old link_v
    | OTHER PHI -> migrate_phi builder instr_old typemap
    | OTHER Select -> migrate_select builder instr_old typemap link_v
    | _ ->
        let msg =
          Format.asprintf "Unsupported instruction: %s"
            (string_of_llvalue instr_old)
        in
        failwith msg
  in
  LLVMap.add instr_old instr_new link_v

let migrate_block llctx b_old b_new typemap link_v link_b =
  let builder = builder_at_end llctx b_new in
  fold_left_instrs
    (fun link_v instr_old ->
      migrate_instr builder instr_old typemap link_v link_b)
    link_v b_old

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

  (* NOTE: Incomings of PHI nodes must be added later *)
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
  let link_v = loop link_v 0 in

  (* (really) migrate PHI nodes for each block *)
  let rec migrate_phi = function
    | Before phi_old when instr_opcode phi_old = PHI ->
        let phi_new = LLVMap.find phi_old link_v in
        let incomings_old = incoming phi_old in
        List.iter
          (fun (v, b) ->
            add_incoming
              ( migrate_to_other_ty v (type_of phi_new) link_v,
                LLBMap.find b link_b )
              phi_new)
          incomings_old;
        phi_old |> instr_succ |> migrate_phi
    | _ -> ()
  in
  Array.iter
    (fun block_old -> block_old |> instr_begin |> migrate_phi)
    blocks_old

(** [redef_fn llctx f_old typemap] redefines and returns new version of [f_old]
    according to [typemap]. *)
let redef_fn llctx f_old typemap =
  let ret_ty, param_tys = move_signature f_old typemap in
  let f_new =
    define_function "" (function_type ret_ty param_tys) (global_parent f_old)
  in
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
    L.debug "Warning: this TYPE mutation result is invalid:\n%s"
      (string_of_llvalue f_new);
    delete_function f_new;
    None)

(* is it ok to change types of f, starting from target? *)
let check_target_for_change_type target f =
  if
    fold_left_all_instr
      (fun accu i -> accu && OpCls.opcls_of i <> UNSUPPORTED)
      true f
  then
    if target |> type_of |> classify_type = Void then false
    else if target |> type_of |> classify_type = Pointer then false
    else if classify_value target = Argument then true
    else if OpCls.opcls_of target = ICMP then false
    else if OpCls.opcls_of target = FCMP then false
    else true
  else false

(** [change_type llctx llm] changes type of a random instruction.
    All the other associated values are recursively changed. *)
let change_type llctx llm =
  let llm = Llvm_transform_utils.clone_module llm in
  let f = choose_function llm in
  let f_params = f |> params |> Array.to_list in
  let all_instrs = fold_left_all_instr (fun accu instr -> instr :: accu) [] f in
  let target = AUtil.choose_random (all_instrs @ f_params) in
  L.debug "target: %s" (string_of_llvalue target);
  if check_target_for_change_type target f then
    (* decide type *)
    let ty_old = type_of target in
    let rec loop i =
      let ty_new =
        if ty_old |> classify_type |> is_realtype then
          AUtil.choose_random !Config.Interests.interesting_float_types
        else
          AUtil.choose_random !Config.Interests.interesting_integer_vector_types
      in
      L.debug "checking %s as new type..." (string_of_lltype ty_new);
      if i = 10 then None
      else if ty_old = ty_new then loop (i + 1)
      else
        match collect_ty_changing_llvs target ty_new (Success LLVMap.empty) with
        | Impossible -> None
        | Retry -> loop (i + 1)
        | Success typemap ->
            L.debug "Available! typemap:";
            LLVMap.iter
              (fun k v ->
                L.debug "%s |-> %s" (string_of_llvalue k) (string_of_lltype v))
              typemap;
            let f_new = redef_fn llctx f typemap in
            verify_and_clean f f_new |> ignore;
            Some llm
    in
    loop 0
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

  (* issue #127 *)
  if List.exists (fun i -> instr_opcode i = PHI) all_instrs then None
  else
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
            let name = value_name f_old in
            let f_new = ALlvm.clone_function_with_retty f_old new_ret_ty in
            ALlvm.delete_function f_old;
            set_value_name name f_new;

            Some llm
        | _ -> None)

(* inner-basicblock mutation (independent of block CFG) *)
let mutate_inner_bb times llctx llm choice_fn importants =
  (* allow up to [times] times to find a proper mutation *)
  let rec loop times () =
    if times = 0 then ([], None)
    else
      let mutation = choice_fn () in
      Format.eprintf "[mutate_inner_bb] %a@." pp_mutation mutation;
      (* L.debug "before:\n%s" (string_of_llmodule llm); *)
      let mutation_result =
        match mutation with
        | CREATE -> create_rand_llv llctx importants llm
        | OPCODE -> subst_rand_instr llctx importants llm
        | OPERAND -> subst_rand_opd llctx importants llm
        | FLAG -> modify_flag llctx llm
        | TYPE -> ([], change_type llctx llm)
        | CUT -> ([], cut_below llctx llm)
        (* | _ -> (None, None, None) *)
      in
      match mutation_result with
      | _, Some _llm ->
          Format.eprintf "[mutate_inner_bb] good@.";
          (* let f = choose_function llm in
             reset_var_names f; *)
          mutation_result
      | _, None -> loop (times - 1) ()
  in

  loop times ()

let run ?(times = 5) llctx llm importants (choice_fn : unit -> mutation_t) =
  (* FIXME: parameterize learning system *)
  mutate_inner_bb times llctx llm choice_fn importants
