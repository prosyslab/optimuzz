let is_arith_op = function
  | Llvm.Opcode.Add | Sub | Mul | UDiv | SDiv | URem | SRem -> true
  | _ -> false

let rec get_list_index l v i =
  match l with
  | [] -> -1
  | h :: t -> if compare h v = 0 then i else get_list_index t v (i + 1)

let is_assignment = function
  | Llvm.Opcode.Invoke | Invalid2 | Add | FAdd | Sub | FSub | Mul | FMul | UDiv
  | SDiv | FDiv | URem | SRem | FRem | Shl | LShr | AShr | And | Or | Xor | Load
  | GetElementPtr | Trunc | ZExt | SExt | FPToUI | FPToSI | UIToFP | SIToFP
  | FPTrunc | FPExt | PtrToInt | IntToPtr | BitCast | ICmp | FCmp | PHI | Select
  | UserOp1 | UserOp2 | VAArg | ExtractElement | InsertElement | ShuffleVector
  | ExtractValue | InsertValue | Call | LandingPad ->
      true
  | _ -> false

let fold_left_all_instr f a m =
  if Llvm.is_declaration m then a
  else
    Llvm.fold_left_blocks
      (fun a blk -> Llvm.fold_left_instrs (fun a instr -> f a instr) a blk)
      a m

let get_return_instr f =
  let list = fold_left_all_instr (fun l g -> g :: l) [] f in
  List.find
    (fun l ->
      l |> Llvm.string_of_llvalue |> String.split_on_char ' '
      |> List.exists (fun g -> compare g "ret" = 0))
    list

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

let random list =
  match list with
  | [] -> failwith "Empty list"
  | _ -> List.nth list (Random.int (List.length list))

let random_change_op op =
  let oplist = [ Llvm.Opcode.Add; Sub; Mul; UDiv; SDiv; URem; SRem ] in
  List.filter (fun x -> compare x op <> 0) oplist |> random

let new_arith_instr llctx instr opcode =
  let open Llvm.Opcode in
  let build_op =
    match opcode with
    | Add -> Llvm.build_add
    | Sub -> Llvm.build_sub
    | Mul -> Llvm.build_mul
    | UDiv -> Llvm.build_udiv
    | SDiv -> Llvm.build_sdiv
    | URem -> Llvm.build_urem
    | SRem -> Llvm.build_srem
    | _ -> failwith "Unsupported"
  in

  build_op (Llvm.operand instr 0) (Llvm.operand instr 1) ""
    (Llvm.builder_before llctx instr)
