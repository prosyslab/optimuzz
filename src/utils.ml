let ( >> ) x f = f x |> ignore

exception Out_of_integer_domain
exception Unsupported

(** [repeat_fun f init t] is [f (... (f (f init)) ...)] ([t] times).
    @raise Invalid_argument if [t] is negative. *)
let repeat_fun f init t =
  if t < 0 then raise (Invalid_argument "Negative t")
  else
    let rec aux accu count =
      if count = 0 then accu else aux (f accu) (count - 1)
    in
    aux init t

(** [list_random l] returns a random element from a list [l].
    @raise Invalid_argument if [l] is empty. *)
let list_random l =
  if l <> [] then List.nth l (Random.int (List.length l))
  else raise (Invalid_argument "empty list")

module OpcodeClass = struct
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

  let random_op_of opcls = opcls |> oplist_of |> list_random

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
        if l <> [] then list_random l else opcode
    | None -> list_random total_list

  let build_arith = function
    | Llvm.Opcode.Add -> Llvm.build_add
    | Sub -> Llvm.build_sub
    | Mul -> Llvm.build_mul
    | UDiv -> Llvm.build_udiv
    | SDiv -> Llvm.build_sdiv
    | URem -> Llvm.build_urem
    | SRem -> Llvm.build_srem
    | _ -> raise Unsupported

  let build_logic = function
    | Llvm.Opcode.Shl -> Llvm.build_shl
    | LShr -> Llvm.build_lshr
    | AShr -> Llvm.build_ashr
    | And -> Llvm.build_and
    | Or -> Llvm.build_or
    | Xor -> Llvm.build_xor
    | _ -> raise Unsupported

  (* each MEM instruction has different operands *)
  let build_mem _ = raise Unsupported

  let build_cast = function
    | Llvm.Opcode.Trunc -> Llvm.build_trunc
    | ZExt -> Llvm.build_zext
    | SExt -> Llvm.build_sext
    | PtrToInt -> Llvm.build_ptrtoint
    | IntToPtr -> Llvm.build_inttoptr
    | BitCast -> Llvm.build_bitcast
    | _ -> raise Unsupported

  let build_cmp icmp = Llvm.build_icmp icmp
  let build_phi = Llvm.build_phi
end

(** [fold_left_all_instr f a m] returns [f (... f (f (f a i1) i2) i3 ...) iN],
    where [i1 ... iN] are the instructions in function [m]. *)
let fold_left_all_instr f a m =
  if Llvm.is_declaration m then a
  else
    Llvm.fold_left_blocks
      (fun a blk -> Llvm.fold_left_instrs (fun a instr -> f a instr) a blk)
      a m

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
  match Llvm.function_begin llm with
  | Before f -> f
  | At_end _ -> failwith "No function defined"

(** [note_module_list l file] print all modules in list[l] to [file]. *)
let note_module_list l file =
  let fp = open_out file in
  List.iter (fun i -> i |> Llvm.string_of_llmodule |> output_string fp) l;
  close_out fp
