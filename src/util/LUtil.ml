(* GENERAL UTILITY FUNCTIONS *)

let ( >> ) x f = f x |> ignore
let command_args args = args |> String.concat " " |> Sys.command

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

(* LLVM UTILITY FUNCTIONS *)

let string_of_opcode = function
  | Llvm.Opcode.Invalid -> "Invalid"
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
  (* assume the sole function for now *)
  match Llvm.function_begin llm with
  | Before f -> f
  | At_end _ -> failwith "No function defined"

(** [replace_hard bef aft] replaces
    all uses of [bef] to [aft] and delete [bef]. *)
let replace_hard bef aft =
  Llvm.replace_all_uses_with bef aft;
  Llvm.delete_instruction bef
