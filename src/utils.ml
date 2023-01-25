exception Out_of_integer_domain

module OpcodeClass = struct
  type opcls_t = TER | ARITH | LOGIC | MEM | CAST | CMP | PHI | OTHER

  let ter_list = []
  let arith_list = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ]
  let logic_list = []
  let mem_list = []
  let cast_list = []
  let phi_list = []
  let other_list = []

  let classify = function
    | Llvm.Opcode.Ret | Br -> TER
    | Add | Sub | Mul | UDiv | SDiv | URem | SRem -> ARITH
    | _ when false -> LOGIC (* Shl | LShr | AShr | And | Or | Xor *)
    | _ when false -> MEM (* Alloca | Load | Store *)
    | _ when false -> CAST
    | ICmp -> CMP
    | PHI -> PHI
    | FAdd | FSub | FMul | FDiv | FRem | FCmp -> raise Out_of_integer_domain
    | _ -> OTHER

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

  (** [build_op opcode] get appropriate build function according to [opcode]. *)
  let build_arith_op = function
    | Llvm.Opcode.Add -> Llvm.build_add
    | Sub -> Llvm.build_sub
    | Mul -> Llvm.build_mul
    | UDiv -> Llvm.build_udiv
    | SDiv -> Llvm.build_sdiv
    | URem -> Llvm.build_urem
    | SRem -> Llvm.build_srem
    | _ -> failwith "Unsupported"
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
  let list =
    fold_left_all_instr
      (fun l g ->
        if g |> Llvm.instr_opcode |> OpcodeClass.is_assignment then g :: l
        else l)
      []
      (i |> Llvm.instr_parent |> Llvm.block_parent)
  in
  let rec aux l i accu =
    match l with
    | [] -> accu
    | h :: t -> if i = h then accu else aux t i (h :: accu)
  in
  aux (List.rev list) i []

(** [get_alloca_from_function i] get all allocated ptr which is declared
    before i(instr) in its ancestral function. *)
let get_alloca_from_function i =
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

(** [list_random l] returns a random element from a list [l]. *)
let list_random l =
  match l with
  | [] -> failwith "Empty list"
  | _ -> List.nth l (Random.int (List.length l))

(** [random_opcode_except opcode] returns an opcode other than [opcode]. *)
let random_opcode_except opcode =
  let opcode_list = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ] in
  list_random
    (match opcode with
    | Some opcode_ex -> List.filter (fun x -> x <> opcode_ex) opcode_list
    | None -> opcode_list)
