include Llvm

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
  | "Ret" -> Llvm.Opcode.Ret
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

(** [fold_left_all_instr f a m] returns [f (... f (f (f a i1) i2) i3 ...) iN],
    where [i1 ... iN] are the instructions in function [m]. *)
let fold_left_all_instr f a m =
  if Llvm.is_declaration m then a
  else Llvm.fold_left_blocks (Llvm.fold_left_instrs f) a m

(** [get_return_instr f] returns ret instruction from [f]. *)
let get_return_instr f =
  List.find
    (fun instr -> Llvm.instr_opcode instr = Llvm.Opcode.Ret)
    (fold_left_all_instr (fun l g -> g :: l) [] f)

(** [get_instrs_before wide i] returns a list of all instrs before [i].
    If [wide], includes all instructions in the ancestral function of [i].
    Else, includes instructions only within the parental block of [i]. *)
let get_instrs_before ~wide i =
  let rec aux accu rev_pos =
    match rev_pos with
    | Llvm.At_start b ->
        if wide then
          match Llvm.block_pred b with
          | At_start _ -> accu
          | After b -> aux accu (Llvm.instr_end b)
        else accu
    | After i -> aux (i :: accu) (Llvm.instr_pred i)
  in
  aux [] (Llvm.instr_pred i)

(** [list_filter_type ty vl] returns
    a filtered version of [vl]; only llvalues with type [ty] remains. *)
let list_filter_type ty vl = List.filter (fun v -> Llvm.type_of v = ty) vl

(** [get_blocks_after bb] returns
    a list of all blocks after [bb] in its parent function. *)
let get_blocks_after bb =
  let rec aux rev_pos accu =
    match rev_pos with
    | Llvm.After block ->
        if block = bb then accu else aux (Llvm.block_pred block) (block :: accu)
    | At_start _ -> failwith "NEVER OCCUR"
  in
  aux (bb |> Llvm.block_parent |> Llvm.block_end) []

(** [choose_function llm] returns an arbitrary function in [llm]. *)
let choose_function llm =
  let rec aux = function
    | Llvm.Before f ->
        if Llvm.is_declaration f then aux (Llvm.function_succ f) else f
    | At_end _ -> failwith "No function defined"
  in
  aux (Llvm.function_begin llm)

(** [replace_hard bef aft] replaces
    all uses of [bef] to [aft] and delete [bef]. *)
let replace_hard bef aft =
  Llvm.replace_all_uses_with bef aft;
  Llvm.delete_instruction bef

let replace_and_ret instr_old instr_new =
  replace_hard instr_old instr_new;
  Some instr_new

let set_opd_and_ret instr i opd =
  Llvm.set_operand instr i opd;
  Some instr

exception Out_of_integer_domain

module TypeBW = struct
  exception Unsupported_Type

  type t = Llvm.lltype
  type bwt = int (* bitwidth *)

  (* support integer type only *)
  let is_llint ty = Llvm.classify_type ty = Llvm.TypeKind.Integer
  let assert_llint ty = if not (is_llint ty) then raise Out_of_integer_domain

  (* bitwidth related functions *)
  let rand_bw () = AUtil.rand 1 64
  let llint_of_bw = Llvm.integer_type
  let bw_of_llint = Llvm.integer_bitwidth

  let random_wider_llint llctx ty =
    let bw = bw_of_llint ty in
    if bw = 64 then raise Unsupported_Type
    else
      let bw_wide = AUtil.rand (bw + 1) 64 in
      llint_of_bw llctx bw_wide

  let random_narrower_llint llctx ty =
    let bw = bw_of_llint ty in
    if bw = 1 then raise Unsupported_Type
    else
      let bw_narrow = AUtil.rand 1 (bw - 1) in
      llint_of_bw llctx bw_narrow
end

module OpcodeClass = struct
  exception Improper_class

  type t = TER | BINARY | MEM | CAST | CMP | PHI | OTHER

  (* use these lists to mark progress *)
  let ter_list = [ Llvm.Opcode.Ret; Br ]

  let binary_list =
    [
      Llvm.Opcode.Add;
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
    ]

  let mem_list = [ Llvm.Opcode.Alloca; Load; Store ]
  let cast_list = [ Llvm.Opcode.Trunc; ZExt; SExt ]
  let cmp_list = [ Llvm.Opcode.ICmp ]
  let phi_list = [ Llvm.Opcode.PHI ]
  let other_list = []

  (* helper for cmp instruction *)
  let cmp_kind = [ Llvm.Icmp.Eq; Ne; Ugt; Uge; Ult; Ule; Sgt; Sge; Slt; Sle ]

  let total_list =
    ter_list @ binary_list @ mem_list @ cast_list @ cmp_list @ phi_list
    @ other_list

  let classify = function
    | Llvm.Opcode.Ret | Br -> TER
    | Add | Sub | Mul | UDiv | SDiv | URem | SRem | Shl | LShr | AShr | And | Or
    | Xor ->
        BINARY
    | Alloca | Load | Store -> MEM
    | Trunc | ZExt | SExt -> CAST
    | ICmp -> CMP
    | PHI -> PHI
    | FAdd | FSub | FMul | FDiv | FRem | FPToUI | FPToSI | UIToFP | SIToFP
    | FPTrunc | FPExt | FCmp ->
        raise Out_of_integer_domain
    | _ -> OTHER

  let oplist_of = function
    | TER -> ter_list
    | BINARY -> binary_list
    | MEM -> mem_list
    | CAST -> cast_list
    | CMP -> cmp_list
    | PHI -> phi_list
    | OTHER -> other_list

  let random_op_of opcls = opcls |> oplist_of |> AUtil.list_random

  (** [random_opcode ()] returns a random opcode. *)
  let random_opcode () = AUtil.list_random total_list

  (** [random_opcode_except opcode] returns another random opcode in its class.
        If [opcode] is the only one in its class, returns [opcode]. *)
  let random_opcode_except opcode =
    let l =
      List.filter (fun x -> x <> opcode) (opcode |> classify |> oplist_of)
    in
    if l <> [] then AUtil.list_random l else opcode

  let random_cmp () = AUtil.list_random cmp_kind

  let build_binary opcode o0 o1 llb =
    (match opcode with
    | Llvm.Opcode.Add -> Llvm.build_add
    | Sub -> Llvm.build_sub
    | Mul -> Llvm.build_mul
    | UDiv -> Llvm.build_udiv
    | SDiv -> Llvm.build_sdiv
    | URem -> Llvm.build_urem
    | SRem -> Llvm.build_srem
    | Shl -> Llvm.build_shl
    | LShr -> Llvm.build_lshr
    | AShr -> Llvm.build_ashr
    | And -> Llvm.build_and
    | Or -> Llvm.build_or
    | Xor -> Llvm.build_xor
    | _ -> raise Improper_class)
      o0 o1 "" llb

  let build_cast opcode o ty llb =
    (match opcode with
    | Llvm.Opcode.Trunc -> Llvm.build_trunc
    | ZExt -> Llvm.build_zext
    | SExt -> Llvm.build_sext
    | _ -> raise Improper_class)
      o ty "" llb

  let build_cmp icmp o0 o1 llb = Llvm.build_icmp icmp o0 o1 "" llb

  let string_of_opcls = function
    | TER -> "TER"
    | BINARY -> "BINARY"
    | MEM -> "MEM"
    | CAST -> "CAST"
    | CMP -> "CMP"
    | PHI -> "PHI"
    | _ -> "OTHER"
end

module Flag = struct
  exception Unsupported_Flag

  let can_overflow = function
    | Llvm.Opcode.Add | Sub | Mul | Shl -> true
    | _ -> false

  let can_be_exact = function
    | Llvm.Opcode.SDiv | UDiv | AShr | LShr -> true
    | _ -> false

  external set_nuw_raw : bool -> Llvm.llvalue -> unit = "llvm_set_nuw"
  external set_nsw_raw : bool -> Llvm.llvalue -> unit = "llvm_set_nsw"
  external set_exact_raw : bool -> Llvm.llvalue -> unit = "llvm_set_exact"
  external is_nuw_raw : Llvm.llvalue -> bool = "llvm_is_nuw"
  external is_nsw_raw : Llvm.llvalue -> bool = "llvm_is_nsw"
  external is_exact_raw : Llvm.llvalue -> bool = "llvm_is_exact"

  let guard_set prereq f flag instr =
    if instr |> Llvm.instr_opcode |> prereq then f flag instr
    else raise Unsupported_Flag

  let set_nuw = guard_set can_overflow set_nuw_raw
  let set_nsw = guard_set can_overflow set_nsw_raw
  let set_exact = guard_set can_be_exact set_exact_raw

  let guard_is prereq f instr =
    if instr |> Llvm.instr_opcode |> prereq then f instr
    else raise Unsupported_Flag

  let is_nuw = guard_is can_overflow is_nuw_raw
  let is_nsw = guard_is can_overflow is_nsw_raw
  let is_exact = guard_is can_be_exact is_exact_raw
end

(** save_ll [target_dif] [output filename] [llmodule]*)
let save_ll dir filename llm =
  let output_name = Filename.concat dir filename in
  print_module output_name llm
