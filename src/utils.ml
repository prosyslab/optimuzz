let is_arith_op = function
  | Llvm.Opcode.Add | FAdd | Sub | FSub | Mul | FMul | UDiv | SDiv | FDiv ->
      true
  | _ -> false

let rec get_list_index l v i =
  match l with
  | [] -> -1
  | h :: t -> if compare h v = 0 then i else get_list_index t v (i + 1)

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

let fold_left_all_instr f a m =
  if Llvm.is_declaration m then a
  else
    Llvm.fold_left_blocks
      (fun a blk -> Llvm.fold_left_instrs (fun a instr -> f a instr) a blk)
      a m

let rec get_arguments_from_list l i m =
  match l with
  | [] -> m
  | h :: t ->
      if compare i h = 0 then m else get_arguments_from_list t i (List.cons h m)

let get_arguments_from_function m i =
  let list =
    fold_left_all_instr
      (fun l g -> if is_assignment (Llvm.instr_opcode g) then g :: l else l)
      [] m
  in
  get_arguments_from_list (List.rev list) i []

let random_change_op op =
  let oplist = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ] in
  List.nth oplist
    (get_list_index oplist op 0 + Random.int (List.length oplist - 1) + 1)

let random list = List.nth list (Random.int (List.length list))
