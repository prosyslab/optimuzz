let ( >> ) x f = f x |> ignore

exception Out_of_integer_domain
exception Unsupported

(** [list_random l] returns a random element from a list [l]. *)
let list_random l = List.nth l (Random.int (List.length l))

module OpcodeClass = struct
  type t = TER | ARITH | LOGIC | MEM | CAST | CMP | PHI | OTHER

  (* use these lists to mark progress *)
  let ter_list = []
  let arith_list = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ]
  let logic_list = [ Llvm.Opcode.Shl; LShr; AShr; And; Or; Xor ]
  let mem_list = [ Llvm.Opcode.Alloca; Load; Store ]
  let cast_list = [ Llvm.Opcode.Trunc; ZExt; SExt; PtrToInt; IntToPtr; BitCast ]
  let cmp_list = [ Llvm.Opcode.ICmp ]
  let phi_list = [] (* PHI *)
  let other_list = []

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
    | _ when false -> PHI
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

  let is_assignment opcode =
    match classify opcode with
    | ARITH | LOGIC | CMP | PHI -> true
    | _ -> (
        (* temporaily except alloca *)
        match opcode with
        | Invoke | Invalid2 | Load | GetElementPtr | Trunc | ZExt | SExt
        | FPToUI | FPToSI | UIToFP | SIToFP | FPTrunc | FPExt | PtrToInt
        | IntToPtr | BitCast | Select | UserOp1 | UserOp2 | VAArg
        | ExtractElement | InsertElement | ShuffleVector | ExtractValue
        | InsertValue | Call | LandingPad ->
            true
        | _ -> false)

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
end

(** [get_list_index l v] returns the index of value [v] in list [l].
    Raises [Not_found] if does not exist. *)
let get_list_index l v =
  let rec aux l i =
    match l with
    | [] -> raise Not_found
    | h :: t -> if h = v then i else aux t (i + 1)
  in
  aux l 0

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

(** [get_assignments_before i] returns
    a list of all assignments before [i] in its ancestral function. *)
let get_assignments_before i =
  let rec aux rev_pos accu =
    match rev_pos with
    | Llvm.At_start _ -> accu
    | After i ->
        aux (Llvm.instr_pred i)
          (if i |> Llvm.instr_opcode |> OpcodeClass.is_assignment then i :: accu
          else accu)
  in
  aux (Llvm.instr_pred i) []

(** [get_alloca_before i] returns
    a list of all allocation pointers before [i] in its ancestral function. *)
let get_alloca_before i =
  let list =
    fold_left_all_instr
      (fun l g ->
        if Llvm.Opcode.Alloca = Llvm.instr_opcode g then g :: l else l)
      []
      (i |> Llvm.instr_parent |> Llvm.block_parent)
  in
  let rec aux l i accu =
    match l with
    | [] -> accu
    | h :: t -> if i = h then accu else aux t i (h :: accu)
  in
  aux (List.rev list) i []

(** [filter_by_type ty vl] returns
    a filtered version of [vl]; only llvalues with type [ty] remains. *)
let filter_by_type ty vl = List.filter (fun v -> Llvm.type_of v = ty) vl

(** [get_blocks_after bb] returns
    a list of all blocks after [bb] in its parent function. *)
let get_blocks_after bb =
  let rec aux rev_pos accu =
    match rev_pos with
    | Llvm.At_start _ -> failwith "NEVER OCCUR"
    | After block ->
        if block = bb then accu else aux (Llvm.block_pred block) (block :: accu)
  in
  aux (bb |> Llvm.block_parent |> Llvm.block_end) []

let all_arith_instrs_of f =
  fold_left_all_instr
    (fun a i ->
      if i |> Llvm.instr_opcode |> OpcodeClass.classify = OpcodeClass.ARITH then
        i :: a
      else a)
    [] f

(** [choose_function llm] returns an arbitrary function in [llm]. *)
let choose_function llm =
  match Llvm.function_begin llm with
  | Before f -> f
  | At_end _ -> failwith "No function defined"
