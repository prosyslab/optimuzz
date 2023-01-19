(** [is_arith_op] check opcode is arithmetic *)
let is_arith_op = function
  | Llvm.Opcode.Add | Sub | Mul | UDiv | SDiv | URem | SRem -> true
  | _ -> false

(** [get_list_index l v] get index of value(v) in list(l) *)
let get_list_index l v =
  let rec aux l i =
    match l with
    | [] -> -1
    | h :: t -> if compare h v = 0 then i else aux t (i + 1)
  in
  aux l 0

(** [is_assignment] check opcode of instruction is assignment *)
let is_assignment = function
  | Llvm.Opcode.Invoke | Invalid2 | Add | FAdd | Sub | FSub | Mul | FMul | UDiv
  | SDiv | FDiv | URem | SRem | FRem | Shl | LShr | AShr | And | Or | Xor | Load
  | GetElementPtr | Trunc | ZExt | SExt | FPToUI | FPToSI | UIToFP | SIToFP
  | FPTrunc | FPExt | PtrToInt | IntToPtr | BitCast | ICmp | FCmp | PHI | Select
  | UserOp1 | UserOp2 | VAArg | ExtractElement | InsertElement | ShuffleVector
  | ExtractValue | InsertValue | Call | LandingPad ->
      true
  | _ -> false

(** [fold_left_all_instr f a m] get all instructions from m(llvalue)
    to a(default value) by f(function) *)
let fold_left_all_instr f a m =
  if Llvm.is_declaration m then a
  else
    Llvm.fold_left_blocks
      (fun a blk -> Llvm.fold_left_instrs (fun a instr -> f a instr) a blk)
      a m

(** [get_return_instr f] get return instruction from f(llvalue) *)
let get_return_instr f =
  let list = fold_left_all_instr (fun l g -> g :: l) [] f in
  List.find
    (fun l ->
      l |> Llvm.string_of_llvalue |> String.split_on_char ' '
      |> List.exists (fun g -> g = "ret"))
    list

(** [get_arguments_from_function m i] get all arguments which is declared
    before i(instr) in m(llvalue) *)
let get_arguments_from_function m i =
  let list =
    fold_left_all_instr
      (fun l g -> if is_assignment (Llvm.instr_opcode g) then g :: l else l)
      [] m
  in
  let rec aux l i m =
    match l with [] -> m | h :: t -> if i = h then m else aux t i (h :: m)
  in
  aux (List.rev list) i []

(** [random list] get random value from list *)
let random list =
  match list with
  | [] -> failwith "Empty list"
  | _ -> List.nth list (Random.int (List.length list))

(** [random_change_op op] get operator different with recent operator(op) *)
let random_change_op op =
  let oplist = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ] in
  List.filter (fun x -> compare x op <> 0) oplist |> random

(** [build_op opcode] get appropriate build function according to opcode*)
let build_op opcode =
  let open Llvm.Opcode in
  match opcode with
  | Add -> Llvm.build_add
  | Sub -> Llvm.build_sub
  | Mul -> Llvm.build_mul
  | UDiv -> Llvm.build_udiv
  | SDiv -> Llvm.build_sdiv
  | URem -> Llvm.build_urem
  | SRem -> Llvm.build_srem
  | _ -> failwith "Unsupported"
