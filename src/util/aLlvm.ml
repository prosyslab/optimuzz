include Llvm

external set_opaque_pointers : llcontext -> bool -> unit
  = "llvm_set_opaque_pointers"

external verify_module : llmodule -> bool = "wrap_llvm_verify_module"
external get_allocated_type : llvalue -> lltype = "llvm_get_alloca_type"

external clone_function : llvalue -> lltype -> llvalue
  = "llvm_transforms_utils_clone_function"
(** [clone_function func ret_ty] returns
    a copy of [func] of return type [ret_ty] and add it to [func]'s module *)

external transfer_instructions : llbasicblock -> llbasicblock -> unit
  = "llvm_bb_transfer_instructions"
(** [transfer_instructions src dst] moves all instructions
    from [src] to the end of [dst] *)

external clean_module_data : llmodule -> unit = "llvm_clean_module_data"
(** [clean_module_data m] removes all metadata from [m] *)

external string_of_constint : llvalue -> string = "llvm_string_of_constantint"
(** [string_of_constint v] get value as string from [v] *)

let string_of_opcode = function
  | Opcode.Invalid -> "Invalid"
  | Ret -> "Ret"
  | Br -> "Br"
  | Switch -> "Switch"
  | IndirectBr -> "IndirectBr"
  | Invoke -> "Invoke"
  | Invalid2 -> "Invalid2"
  | Unreachable -> "Unreachable"
  | Add -> "Add"
  | FAdd -> "FAdd"
  | Sub -> "Sub"
  | FSub -> "FSub"
  | Mul -> "Mul"
  | FMul -> "FMul"
  | UDiv -> "UDiv"
  | SDiv -> "SDiv"
  | FDiv -> "FDiv"
  | URem -> "URem"
  | SRem -> "SRem"
  | FRem -> "FRem"
  | Shl -> "Shl"
  | LShr -> "LShr"
  | AShr -> "AShr"
  | And -> "And"
  | Or -> "Or"
  | Xor -> "Xor"
  | Alloca -> "Alloca"
  | Load -> "Load"
  | Store -> "Store"
  | GetElementPtr -> "GetElementPtr"
  | Trunc -> "Trunc"
  | ZExt -> "ZExt"
  | SExt -> "SExt"
  | FPToUI -> "FPToUI"
  | FPToSI -> "FPToSI"
  | UIToFP -> "UIToFP"
  | SIToFP -> "SIToFP"
  | FPTrunc -> "FPTrunc"
  | FPExt -> "FPExt"
  | PtrToInt -> "PtrToInt"
  | IntToPtr -> "IntToPtr"
  | BitCast -> "BitCast"
  | ICmp -> "ICmp"
  | FCmp -> "FCmp"
  | PHI -> "PHI"
  | Call -> "Call"
  | Select -> "Select"
  | UserOp1 -> "UserOp1"
  | UserOp2 -> "UserOp2"
  | VAArg -> "VAArg"
  | ExtractElement -> "ExtractElement"
  | InsertElement -> "InsertElement"
  | ShuffleVector -> "ShuffleVector"
  | ExtractValue -> "ExtractValue"
  | InsertValue -> "InsertValue"
  | Fence -> "Fence"
  | AtomicCmpXchg -> "AtomicCmpXchg"
  | AtomicRMW -> "AtomicRMW"
  | Resume -> "Resume"
  | LandingPad -> "LandingPad"
  | _ -> "Unknown Opcode"

let opcode_of_string = function
  | "Ret" -> Opcode.Ret
  | "Br" -> Br
  | "Switch" -> Switch
  | "IndirectBr" -> IndirectBr
  | "Invoke" -> Invoke
  | "Invalid2" -> Invalid2
  | "Unreachable" -> Unreachable
  | "Add" -> Add
  | "FAdd" -> FAdd
  | "Sub" -> Sub
  | "FSub" -> FSub
  | "Mul" -> Mul
  | "FMul" -> FMul
  | "UDiv" -> UDiv
  | "SDiv" -> SDiv
  | "FDiv" -> FDiv
  | "URem" -> URem
  | "SRem" -> SRem
  | "FRem" -> FRem
  | "Shl" -> Shl
  | "LShr" -> LShr
  | "AShr" -> AShr
  | "And" -> And
  | "Or" -> Or
  | "Xor" -> Xor
  | "Alloca" -> Alloca
  | "Load" -> Load
  | "Store" -> Store
  | "GetElementPtr" -> GetElementPtr
  | "Trunc" -> Trunc
  | "ZExt" -> ZExt
  | "SExt" -> SExt
  | "FPToUI" -> FPToUI
  | "FPToSI" -> FPToSI
  | "UIToFP" -> UIToFP
  | "SIToFP" -> SIToFP
  | "FPTrunc" -> FPTrunc
  | "FPExt" -> FPExt
  | "PtrToInt" -> PtrToInt
  | "IntToPtr" -> IntToPtr
  | "BitCast" -> BitCast
  | "ICmp" -> ICmp
  | "FCmp" -> FCmp
  | "PHI" -> PHI
  | "Call" -> Call
  | "Select" -> Select
  | "UserOp1" -> UserOp1
  | "UserOp2" -> UserOp2
  | "VAArg" -> VAArg
  | "ExtractElement" -> ExtractElement
  | "InsertElement" -> InsertElement
  | "ShuffleVector" -> ShuffleVector
  | "ExtractValue" -> ExtractValue
  | "InsertValue" -> InsertValue
  | "Fence" -> Fence
  | "AtomicCmpXchg" -> AtomicCmpXchg
  | "AtomicRMW" -> AtomicRMW
  | "Resume" -> Resume
  | "LandingPad" -> LandingPad
  | _ -> Invalid

let string_of_icmp = function
  | Icmp.Eq -> "eq"
  | Ne -> "ne"
  | Ugt -> "ugt"
  | Uge -> "uge"
  | Ult -> "ult"
  | Ule -> "ule"
  | Sgt -> "sgt"
  | Sge -> "sge"
  | Slt -> "slt"
  | Sle -> "sle"

external get_shufflevector_mask_inner : llvalue -> llvalue
  = "llvm_get_shufflevector_mask"
(** [transfer_instructions src dst] moves all instructions
    from [src] to the end of [dst] *)

external set_shufflevector_mask_inner : llvalue -> llvalue -> unit
  = "llvm_set_shufflevector_mask"
(** [transfer_instructions src dst] moves all instructions
  from [src] to the end of [dst] *)

let get_shufflevector_mask instr =
  match classify_value instr with
  | Instruction opc when opc = ShuffleVector ->
      get_shufflevector_mask_inner instr
  | _ -> invalid_arg ("Not a shufflevector: " ^ string_of_llvalue instr)

let set_shufflevector_mask mask instr =
  assert (is_constant mask && mask |> type_of |> classify_type = Vector);
  match classify_value instr with
  | Instruction opc when opc = ShuffleVector ->
      set_shufflevector_mask_inner mask instr
  | _ -> invalid_arg ("Not a shufflevector: " ^ string_of_llvalue instr)

(** [mk_const_vec vecty i] returns [<i, ..., i>] (vector of type [vecty]).
    [i] is an integer (OCaml level), not [llvalue]. *)
let mk_const_vec vecty i =
  const_vector
    (Array.make (vector_size vecty)
       (const_int_of_string (element_type vecty) i 10))

(** [fold_left_all_instr f a m] returns [f (... f (f (f a i1) i2) i3 ...) iN],
    where [i1 ... iN] are the instructions in function [m]. *)
let fold_left_all_instr f a m =
  if is_declaration m then a else fold_left_blocks (fold_left_instrs f) a m

let filter_all_instr pred func =
  fold_left_all_instr
    (fun accu instr -> if pred instr then instr :: accu else accu)
    [] func

let any_all_instr pred func =
  fold_left_all_instr (fun b instr -> b || pred instr) false func

let for_all_instr pred func =
  fold_left_all_instr (fun b instr -> b && pred instr) true func

(** [iter_all_instr f m] applies function f to each of instructions in function m*)
let iter_all_instr f m =
  if is_declaration m then () else iter_blocks (iter_instrs f) m

(** [get_return_instr f] returns ret instruction from [f]. *)
let get_return_instr func =
  let rets =
    func |> filter_all_instr (fun instr -> instr_opcode instr = Opcode.Ret)
  in
  match rets with [] -> None | ret :: _ -> Some ret

let is_variable instr =
  match instr_opcode instr with Invalid | Store -> false | _ -> true

let is_assignment = function
  | Llvm.Opcode.Invoke | Invalid2 | Add | FAdd | Sub | FSub | Mul | FMul | UDiv
  | SDiv | FDiv | URem | SRem | FRem | Shl | LShr | AShr | And | Or | Xor
  | Alloca | Load | GetElementPtr | Trunc | ZExt | SExt | FPToUI | FPToSI
  | UIToFP | SIToFP | FPTrunc | FPExt | PtrToInt | IntToPtr | BitCast | ICmp
  | FCmp | PHI | Select | UserOp1 | UserOp2 | VAArg | ExtractElement
  | InsertElement | ShuffleVector | ExtractValue | InsertValue | Call
  | LandingPad ->
      true
  | _ -> false

let is_noncommutative_binary instr =
  match Llvm.instr_opcode instr with
  | Llvm.Opcode.Sub | FSub | UDiv | SDiv | FDiv | URem | SRem | FRem -> true
  | _ -> false

let is_call instr =
  match Llvm.instr_opcode instr with Llvm.Opcode.Call -> true | _ -> false

let is_llvm_function f =
  let r = Str.regexp "llvm\\..+" in
  Str.string_match r (Llvm.value_name f) 0

let is_llvm_intrinsic instr =
  if is_call instr then
    let callee_expr = Llvm.operand instr (Llvm.num_operands instr - 1) in
    is_llvm_function callee_expr
  else false

let read_ll llctx filepath =
  try
    let buf = Llvm.MemoryBuffer.of_file filepath in
    Llvm_irreader.parse_ir llctx buf |> Result.ok
  with Llvm_irreader.Error msg -> Result.Error msg

(** [save_ll target_dir output filename llmodule] saves [llmodule]
 *  under [target_dir], named as [filename].
 *  This functions returns the fully qualified filename of the produced file. *)
let save_ll dir filename llm =
  let output_name = Filename.concat dir filename in
  print_module output_name llm;
  output_name

(** [get_function instr] returns the function that contains [instr]. *)
let get_function instr = instr |> Llvm.instr_parent |> Llvm.block_parent

(** [get_instr_before wide instr] returns a instr before [i].
    If [wide], searches all instructions in the ancestral function of [i].
    Else, searches instructions only within the parental block of [i]. *)
let get_instr_before ~wide instr =
  let is_interesting i =
    (* we are looking for non-terminator assignment instruction *)
    (not (is_terminator i)) && i |> instr_opcode |> is_assignment
  in

  if wide then
    let rec aux res rev_pos =
      match rev_pos with
      | At_start b -> (
          (* For wide search, also investigate preceding blocks in the function *)
          match block_pred b with
          | At_start _ -> None
          | After b -> aux res (instr_end b))
      | After i -> if is_interesting i then Some i else aux res (instr_pred i)
    in
    aux None (instr_pred instr)
  else
    let rec aux res rev_pos =
      match rev_pos with
      (* For narrow search, only look into the block which contains the instruction *)
      | At_start _ -> None
      | After i -> if is_interesting i then Some i else aux res (instr_pred i)
    in
    let f = instr |> get_function in
    let entry = entry_block f in
    aux None (instr_end entry)

(** [get_instrs_before wide i] returns a list of all instrs before [i].
    If [wide], includes all instructions in the ancestral function of [i].
    Else, includes instructions only within the parental block of [i]. *)
let get_instrs_before ~wide i =
  let rec aux accu rev_pos =
    match rev_pos with
    | At_start b ->
        if wide then
          match block_pred b with
          | At_start _ -> accu
          | After b -> aux accu (instr_end b)
        else accu
    | After i -> aux (i :: accu) (instr_pred i)
  in
  aux [] (instr_pred i)

(** [get_blocks_after bb] returns
    a list of all blocks after [bb] in its parent function. *)
let get_blocks_after bb =
  let rec aux rev_pos accu =
    match rev_pos with
    | After block ->
        if block = bb then accu else aux (block_pred block) (block :: accu)
    | At_start _ -> failwith "NEVER OCCUR"
  in
  aux (bb |> block_parent |> block_end) []

(** [choose_function llm] returns an arbitrary function in [llm]. *)
let choose_function llm =
  let rec aux = function
    | Before f -> if is_declaration f then aux (function_succ f) else f
    | At_end _ -> failwith "No function defined"
  in
  aux (function_begin llm)

(** [replace_hard before after] replaces
    all uses of [before] to [after] and delete [before]. *)
let replace_hard before after =
  replace_all_uses_with before after;
  delete_instruction before

(* OpcodeClass.t follows classification of LLVM language reference:
   https://llvm.org/docs/LangRef.html *)
module OpcodeClass = struct
  (* NEVER construct this type directly, use classify *)
  type t =
    | TER of Opcode.t
    | BINARY
    | VEC of Opcode.t
    | MEM of Opcode.t
    | CAST
    | OTHER of Opcode.t
    | UNSUPPORTED

  let ter_arr = [| Opcode.Ret; Br |]

  let binary_arr =
    [|
      Opcode.Add;
      Sub;
      Mul;
      UDiv;
      SDiv;
      URem;
      SRem;
      Shl;
      LShr;
      AShr;
      And;
      Or;
      Xor;
    |]

  let vec_arr = [| Opcode.ExtractElement; InsertElement; ShuffleVector |]
  let mem_arr = [| Opcode.Alloca; Load; Store |]
  let cast_arr = [| Opcode.Trunc; ZExt; SExt |]
  let other_arr = [| Opcode.ICmp; PHI; Select |]

  (* helper for cmp instruction *)
  let icmp_kind = [| Icmp.Eq; Ne; Ugt; Uge; Ult; Ule; Sgt; Sge; Slt; Sle |]

  let total_arr =
    Array.concat [ ter_arr; binary_arr; vec_arr; mem_arr; cast_arr; other_arr ]

  let classify opc =
    match opc with
    | Opcode.Ret | Br -> TER opc
    | Add | Sub | Mul | UDiv | SDiv | URem | SRem | Shl | LShr | AShr | And | Or
    | Xor ->
        BINARY
    | ExtractElement | InsertElement | ShuffleVector -> VEC opc
    | Alloca | Load | Store -> MEM opc
    | Trunc | ZExt | SExt -> CAST
    | ICmp | PHI | Select -> OTHER opc
    | _ -> UNSUPPORTED

  let opcls_of instr = instr |> instr_opcode |> classify

  (** [random_opcode ()] returns a random opcode. *)
  let random_opcode () = AUtil.choose_arr total_arr

  (** [random_binary_except opcode] returns another random opcode in BINARY
      except [opcode]. *)
  let random_binary_except opcode = AUtil.arr_random_except binary_arr opcode

  let random_icmp () = AUtil.choose_arr icmp_kind
  let random_icmp_except opcode = AUtil.arr_random_except icmp_kind opcode

  let build_binary opc o0 o1 llb =
    (match opc with
    | Opcode.Add -> build_add
    | Sub -> build_sub
    | Mul -> build_mul
    | UDiv -> build_udiv
    | SDiv -> build_sdiv
    | URem -> build_urem
    | SRem -> build_srem
    | Shl -> build_shl
    | LShr -> build_lshr
    | AShr -> build_ashr
    | And -> build_and
    | Or -> build_or
    | Xor -> build_xor
    | _ -> invalid_arg (string_of_opcode opc ^ " is not a binary opcode."))
      o0 o1 "" llb

  let build_cast opc o ty llb =
    (match opc with
    | Opcode.Trunc -> build_trunc
    | ZExt -> build_zext
    | SExt -> build_sext
    | _ -> invalid_arg (string_of_opcode opc ^ " is not a cast opcode."))
      o ty "" llb

  let build_icmp icmp o0 o1 llb = build_icmp icmp o0 o1 "" llb

  let string_of_opcls = function
    | TER opc -> Printf.sprintf "TER (%s)" (string_of_opcode opc)
    | BINARY -> "BINARY"
    | VEC opc -> Printf.sprintf "VEC (%s)" (string_of_opcode opc)
    | MEM opc -> Printf.sprintf "MEM (%s)" (string_of_opcode opc)
    | CAST -> "CAST"
    | OTHER opc -> Printf.sprintf "OTHER (%s)" (string_of_opcode opc)
    | UNSUPPORTED -> "UNSUPPORTED"
end

module Flag = struct
  exception Unsupported_Flag

  let can_overflow = function
    | Opcode.Add | Sub | Mul | Shl -> true
    | _ -> false

  let can_be_exact = function
    | Opcode.SDiv | UDiv | AShr | LShr -> true
    | _ -> false

  external set_nuw_raw : bool -> llvalue -> unit = "llvm_set_nuw"
  external set_nsw_raw : bool -> llvalue -> unit = "llvm_set_nsw"
  external set_exact_raw : bool -> llvalue -> unit = "llvm_set_exact"
  external is_nuw_raw : llvalue -> bool = "llvm_is_nuw"
  external is_nsw_raw : llvalue -> bool = "llvm_is_nsw"
  external is_exact_raw : llvalue -> bool = "llvm_is_exact"

  let guard_set prereq f flag instr =
    if instr |> instr_opcode |> prereq then f flag instr
    else raise Unsupported_Flag

  let set_nuw = guard_set can_overflow set_nuw_raw
  let set_nsw = guard_set can_overflow set_nsw_raw
  let set_exact = guard_set can_be_exact set_exact_raw

  let guard_is prereq f instr =
    if instr |> instr_opcode |> prereq then f instr else raise Unsupported_Flag

  let is_nuw = guard_is can_overflow is_nuw_raw
  let is_nsw = guard_is can_overflow is_nsw_raw
  let is_exact = guard_is can_be_exact is_exact_raw
end

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

module LLVMap = Map.Make (struct
  type t = llvalue

  let compare = compare
end)

let block_name block = block |> value_of_block |> value_name

module LLBMap = Map.Make (struct
  type t = llbasicblock

  (* use block name as key *)
  let compare llb0 llb1 = compare (block_name llb0) (block_name llb1)
end)

(** [reset_var_names f] sets names of all parameters and instructions in
    function [f]. This is specially useful when we have to assure all values
    have own names. *)
let reset_var_names f =
  let aux () =
    let name i = "val" ^ string_of_int i in
    let start =
      Array.fold_left
        (fun accu param ->
          set_value_name (name accu) param;
          accu + 1)
        0 (params f)
    in
    fold_left_all_instr
      (fun accu i ->
        if i |> type_of |> classify_type <> Void then (
          set_value_name (name accu) i;
          accu + 1)
        else accu)
      start f
    |> ignore
  in

  (* To resolve names like %val01,
     which occurs when we set name %val0 when there is already %val0,
     we have to call this twice. *)
  () |> aux |> aux

let reset_fun_names llm =
  let name i = "fun" ^ string_of_int i in
  fold_left_functions
    (fun accu f ->
      set_value_name (name accu) f;
      accu + 1)
    0 llm
  |> ignore

module ChangeRetVal = struct
  let find_block_by_name f name =
    match
      fold_left_blocks
        (fun accu block ->
          if Option.is_some accu then accu
          else if block_name block = name then Some block
          else accu)
        None f
    with
    | Some block -> block
    | None -> failwith ("No block named " ^ name)

  let is_function_supported f =
    for_all_instr (fun i -> OpcodeClass.opcls_of i <> UNSUPPORTED) f

  let check_target target =
    if
      target |> type_of |> classify_type = Void
      || target
         |> type_of
         |> classify_type
         = Pointer (*When getelementptr supported, revise this*)
    then false
    else true

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
          const_int_of_string ty_new (llv_old |> string_of_constint) 10
      | Integer, Vector ->
          let el_ty = element_type ty_new in
          let vec_size = vector_size ty_new in
          let llv_arr =
            Array.make vec_size
              (const_int_of_string el_ty (llv_old |> string_of_constint) 10)
          in
          const_vector llv_arr
      | Vector, Integer ->
          const_int_of_string ty_new
            (aggregate_element llv_old 0 |> Option.get |> string_of_constint)
            10
      | Vector, Vector ->
          let el_ty = element_type ty_new in
          let vec_size = vector_size ty_new in
          let llv_arr =
            Array.make vec_size
              (const_int_of_string el_ty
                 (aggregate_element llv_old 0
                 |> Option.get
                 |> string_of_constint)
                 10)
          in
          const_vector llv_arr
      | _ -> failwith "Unsupported type migration"

  let migrate_self llv link_v =
    if is_constant llv then migrate_const llv (type_of llv)
    else LLVMap.find llv link_v

  let migrate_ter builder instr_old link_v link_b target =
    match instr_opcode instr_old with
    | Ret ->
        if num_operands target = 0 then
          failwith "return type is void in subst_ret"
        else build_ret (migrate_self target link_v) builder
    | Br -> (
        let find_block = Fun.flip LLBMap.find link_b in
        match get_branch instr_old with
        | Some (`Conditional (cond, tb, fb)) ->
            build_cond_br (migrate_self cond link_v) (find_block tb)
              (find_block fb) builder
        | Some (`Unconditional dest) -> build_br (find_block dest) builder
        | None -> failwith "Not supporting other kind of branches")
    | _ -> failwith "NEVER OCCUR"

  let migrate_binary builder instr_old link_v =
    let opc = instr_opcode instr_old in
    let opd0 = migrate_self (operand instr_old 0) link_v in
    let opd1 = migrate_self (operand instr_old 1) link_v in
    OpcodeClass.build_binary opc opd0 opd1 builder

  let migrate_mem builder instr_old link_v =
    match instr_opcode instr_old with
    | Alloca -> build_alloca (get_allocated_type instr_old) "" builder
    | Load ->
        let opd = operand instr_old 0 in
        build_load (type_of instr_old) (migrate_self opd link_v) "" builder
    | Store ->
        build_store
          (migrate_self (operand instr_old 0) link_v)
          (migrate_self (operand instr_old 1) link_v)
          builder
    | _ -> failwith "NEVER OCCUR"

  let migrate_cast builder instr_old link_v =
    let ty = type_of instr_old in
    let opd = migrate_self (operand instr_old 0) link_v in
    match instr_opcode instr_old with
    | SExt -> build_sext opd ty "" builder
    | ZExt -> build_zext opd ty "" builder
    | Trunc -> build_trunc opd ty "" builder
    | _ -> failwith "Opcode is not cast"

  let migrate_icmp builder instr_old link_v =
    let opd0 = migrate_self (operand instr_old 0) link_v in
    let opd1 = migrate_self (operand instr_old 1) link_v in
    let build_icmp o0 o1 =
      OpcodeClass.build_icmp
        (icmp_predicate instr_old |> Option.get)
        o0 o1 builder
    in
    build_icmp opd0 opd1

  let migrate_phi builder instr_old =
    let ty = type_of instr_old in
    build_empty_phi ty "" builder

  let migrate_select builder instr_old link_v =
    let opd0 = migrate_self (operand instr_old 0) link_v in
    let opd1 = migrate_self (operand instr_old 1) link_v in
    let opd2 = migrate_self (operand instr_old 2) link_v in

    build_select opd0 opd1 opd2 "" builder

  let migrate_instr builder instr_old link_v link_b target =
    let instr_new =
      match OpcodeClass.opcls_of instr_old with
      | TER _ -> migrate_ter builder instr_old link_v link_b target
      | BINARY -> migrate_binary builder instr_old link_v
      | MEM _ -> migrate_mem builder instr_old link_v
      | CAST -> migrate_cast builder instr_old link_v
      | OTHER ICmp -> migrate_icmp builder instr_old link_v
      | OTHER PHI -> migrate_phi builder instr_old
      | OTHER Select -> migrate_select builder instr_old link_v
      | _ -> failwith "Unsupported instruction"
    in
    if instr_old |> type_of |> classify_type <> Void then
      set_value_name (value_name instr_old) instr_new;
    LLVMap.add instr_old instr_new link_v

  let migrate_block llctx b_old b_new link_v link_b target =
    let builder = builder_at_end llctx b_new in
    fold_left_instrs
      (fun link_v instr_old ->
        migrate_instr builder instr_old link_v link_b target)
      link_v b_old

  let migrate llctx f_old f_new target =
    let blocks_old = basic_blocks f_old in
    let blocks_new = basic_blocks f_new in
    let params_old = params f_old in
    let params_new = params f_new in
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
            accu link_b target
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
              add_incoming (migrate_self v link_v, LLBMap.find b link_b) phi_new)
            incomings_old;
          phi_old |> instr_succ |> migrate_phi
      | _ -> ()
    in
    Array.iter
      (fun block_old -> block_old |> instr_begin |> migrate_phi)
      blocks_old
end

let hash_llm llm = string_of_llmodule llm |> Hashtbl.hash

module LLModuleSet = struct
  include Hashtbl.Make (struct
    type t = llmodule

    let equal a b = string_of_llmodule a = string_of_llmodule b
    let hash = hash_llm
  end)

  let get_new_name set llm =
    match find_opt set llm with
    | Some _ -> None
    | None ->
        let h = hash_llm llm in
        Format.sprintf "id:%010d.ll" h |> Option.some
end
