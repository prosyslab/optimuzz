exception Improper_class
exception Out_of_integer_domain
exception Unsupported

module TypeBW = struct
  type t = Llvm.lltype
  type bwt = int (* bitwidth *)

  (* support integer type only *)
  let is_llint ty = Llvm.classify_type ty = Llvm.TypeKind.Integer
  let assert_llint ty = if not (is_llint ty) then raise Out_of_integer_domain

  (* bitwidth related functions *)
  let rand_bw () = LUtil.rand 1 64
  let llint_of_bw = Llvm.integer_type
  let bw_of_llint = Llvm.integer_bitwidth

  let random_wider_llint llctx ty =
    let bw = bw_of_llint ty in
    if bw = 64 then raise Unsupported
    else
      let bw_wide = LUtil.rand (bw + 1) 64 in
      llint_of_bw llctx bw_wide

  let random_narrower_llint llctx ty =
    let bw = bw_of_llint ty in
    if bw = 1 then raise Unsupported
    else
      let bw_narrow = LUtil.rand 1 (bw - 1) in
      llint_of_bw llctx bw_narrow
end

module OpcodeClass = struct
  type t = TER | BINARY | MEM | CAST | CMP | PHI

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

  (* helper for cmp instruction *)
  let cmp_kind = [ Llvm.Icmp.Eq; Ne; Ugt; Uge; Ult; Ule; Sgt; Sge; Slt; Sle ]

  let total_list =
    ter_list @ binary_list @ mem_list @ cast_list @ cmp_list @ phi_list

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
    | _ -> raise Unsupported

  let oplist_of = function
    | TER -> ter_list
    | BINARY -> binary_list
    | MEM -> mem_list
    | CAST -> cast_list
    | CMP -> cmp_list
    | PHI -> phi_list

  let random_op_of opcls = opcls |> oplist_of |> LUtil.list_random

  (** [random_opcode ()] returns a random opcode. *)
  let random_opcode () = LUtil.list_random total_list

  (** [random_opcode_except opcode] returns another random opcode in its class.
      If [opcode] is the only one in its class, returns [opcode]. *)
  let random_opcode_except opcode =
    let l =
      List.filter (fun x -> x <> opcode) (opcode |> classify |> oplist_of)
    in
    if l <> [] then LUtil.list_random l else opcode

  let random_cmp () = LUtil.list_random cmp_kind

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
end
