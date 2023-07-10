exception Improper_class
exception Out_of_integer_domain
exception Unsupported

type t = TER | ARITH | LOGIC | MEM | CAST | CMP | PHI | OTHER

(* use these lists to mark progress *)
let ter_list = [ Llvm.Opcode.Ret; Br ]
let arith_list = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ]
let logic_list = [ Llvm.Opcode.Shl; LShr; AShr; And; Or; Xor ]
let mem_list = [ Llvm.Opcode.Alloca; Load; Store ]
let cast_list = [ Llvm.Opcode.Trunc; ZExt; SExt; PtrToInt; IntToPtr; BitCast ]
let cmp_list = [ Llvm.Opcode.ICmp ]
let phi_list = [ Llvm.Opcode.PHI ] (* PHI *)
let other_list = []

(* helper for cmp instruction *)
let cmp_kind = [ Llvm.Icmp.Eq; Ne; Ugt; Uge; Ult; Ule; Sgt; Sge; Slt; Sle ]

let total_list =
  ter_list @ arith_list @ logic_list @ mem_list @ cast_list @ cmp_list
  @ phi_list @ other_list

let classify = function
  | Llvm.Opcode.Ret | Br -> TER
  | Add | Sub | Mul | UDiv | SDiv | URem | SRem -> ARITH
  | Shl | LShr | AShr | And | Or | Xor -> LOGIC
  | Alloca | Load | Store -> MEM
  | Trunc | ZExt | SExt | PtrToInt | IntToPtr | BitCast -> CAST
  | ICmp -> CMP
  | PHI -> PHI
  | FAdd | FSub | FMul | FDiv | FRem | FPToUI | FPToSI | UIToFP | SIToFP
  | FPTrunc | FPExt | FCmp ->
      raise Out_of_integer_domain
  | _ -> OTHER

let oplist_of = function
  | TER -> ter_list
  | ARITH -> arith_list
  | LOGIC -> logic_list
  | MEM -> mem_list
  | CAST -> cast_list
  | CMP -> cmp_list
  | PHI -> phi_list
  | OTHER -> other_list

let random_op_of opcls = opcls |> oplist_of |> LUtil.list_random

(** [random_opcode_except opcode] returns an opcode
      of its class other than [opcode] if given,
      else, it returns a totally random opcode.
      If [opcode] is the only one in its class, returns [opcode]. *)
let random_opcode_except opcode =
  match opcode with
  | Some opcode ->
      let l =
        List.filter (fun x -> x <> opcode) (opcode |> classify |> oplist_of)
      in
      if l <> [] then LUtil.list_random l else opcode
  | None -> LUtil.list_random total_list

let build_arith opcode o0 o1 llb =
  (match opcode with
  | Llvm.Opcode.Add -> Llvm.build_add
  | Sub -> Llvm.build_sub
  | Mul -> Llvm.build_mul
  | UDiv -> Llvm.build_udiv
  | SDiv -> Llvm.build_sdiv
  | URem -> Llvm.build_urem
  | SRem -> Llvm.build_srem
  | _ -> raise Improper_class)
    o0 o1 "" llb

let build_logic opcode o0 o1 llb =
  (match opcode with
  | Llvm.Opcode.Shl -> Llvm.build_shl
  | LShr -> Llvm.build_lshr
  | AShr -> Llvm.build_ashr
  | And -> Llvm.build_and
  | Or -> Llvm.build_or
  | Xor -> Llvm.build_xor
  | _ -> raise Improper_class)
    o0 o1 "" llb

(* each MEM instruction has different operands *)
let build_mem _ = raise Unsupported

let build_cast opcode o ty llb =
  (match opcode with
  | Llvm.Opcode.Trunc -> Llvm.build_trunc
  | ZExt -> Llvm.build_zext
  | SExt -> Llvm.build_sext
  | PtrToInt -> Llvm.build_ptrtoint
  | IntToPtr -> Llvm.build_inttoptr
  | BitCast -> Llvm.build_bitcast
  | _ -> raise Improper_class)
    o ty "" llb

let build_cmp icmp o0 o1 llb = Llvm.build_icmp icmp o0 o1 "" llb

(* TODO: embed empty quotes *)
let build_phi = Llvm.build_phi

let string_of_opcls = function
  | TER -> "TER"
  | ARITH -> "ARITH"
  | LOGIC -> "LOGIC"
  | MEM -> "MEM"
  | CAST -> "CAST"
  | CMP -> "CMP"
  | PHI -> "PHI"
  | OTHER -> "OTHER"
