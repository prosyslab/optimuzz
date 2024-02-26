include Llvm

external set_opaque_pointers : llcontext -> bool -> unit
  = "llvm_set_opaque_pointers"

external verify_module : llmodule -> bool = "wrap_llvm_verify_module"
external get_allocated_type : llvalue -> lltype = "llvm_get_alloca_type"

external clone_function : llvalue -> lltype -> llvalue
  = "llvm_transforms_utils_clone_function"
(** [clone_function func ret_ty] returns
    a copy of [func] of return type [ret_ty] and add it to [func]'s module *)

external transfer_instructions : llbasicblock -> llbasicblock -> unit
  = "llvm_bb_transfer_instructions"
(** [transfer_instructions src dst] moves all instructions
    from [src] to the end of [dst] *)

external clean_module_data : llmodule -> unit = "llvm_clean_module_data"
(** [clean_module_data m] removes all metadata from [m] *)

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
  | "Ret" -> Opcode.Ret
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
  if is_declaration m then a else fold_left_blocks (fold_left_instrs f) a m

let filter_all_instr pred func =
  fold_left_all_instr
    (fun accu instr -> if pred instr then instr :: accu else accu)
    [] func

let any_all_instr pred func =
  fold_left_all_instr (fun b instr -> b || pred instr) false func

let for_all_instr pred func =
  fold_left_all_instr (fun b instr -> b && pred instr) true func

(** [iter_all_instr f m] applies function f to each of instructions in function m*)
let iter_all_instr f m =
  if is_declaration m then () else iter_blocks (iter_instrs f) m

(** [get_return_instr f] returns ret instruction from [f]. *)
let get_return_instr func =
  let rets =
    func |> filter_all_instr (fun instr -> instr_opcode instr = Opcode.Ret)
  in
  match rets with [] -> None | ret :: _ -> Some ret

let is_variable instr =
  match instr_opcode instr with Invalid | Store -> false | _ -> true

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

let is_noncommutative_binary instr =
  match Llvm.instr_opcode instr with
  | Llvm.Opcode.Sub | FSub | UDiv | SDiv | FDiv | URem | SRem | FRem -> true
  | _ -> false

let is_call instr =
  match Llvm.instr_opcode instr with Llvm.Opcode.Call -> true | _ -> false

let is_llvm_function f =
  let r = Str.regexp "llvm\\..+" in
  Str.string_match r (Llvm.value_name f) 0

let is_llvm_intrinsic instr =
  if is_call instr then
    let callee_expr = Llvm.operand instr (Llvm.num_operands instr - 1) in
    is_llvm_function callee_expr
  else false

(* mutation options *)
let interesting_integers =
  ref [ 0; 1; 2; 255 (*0xFF*); 65535 (*0xFFFF*); 4294967295 (* 0xFFFFFFFF *) ]

let interesting_integer_types = ref []
let interesting_vector_types = ref []
let interesting_types = ref []

let set_intereseting_types llctx =
  interesting_integer_types :=
    [
      integer_type llctx 1;
      integer_type llctx 8;
      integer_type llctx 10;
      integer_type llctx 32;
      integer_type llctx 34;
      integer_type llctx 64;
    ];
  interesting_vector_types :=
    [
      vector_type (i1_type llctx) 1;
      vector_type (i1_type llctx) 4;
      vector_type (i8_type llctx) 1;
      vector_type (i8_type llctx) 4;
      vector_type (i32_type llctx) 1;
      vector_type (i32_type llctx) 4;
    ];
  interesting_types := !interesting_integer_types @ !interesting_vector_types

let read_ll llctx filepath =
  let buf = Llvm.MemoryBuffer.of_file filepath in
  Llvm_irreader.parse_ir llctx buf

(** [save_ll target_dir output filename llmodule] saves [llmodule]
     to [target_dir] and returns the path to the saved file. *)
let save_ll dir filename llm =
  let output_name = Filename.concat dir filename in
  print_module output_name llm;
  output_name

(** [get_function instr] returns the function that contains [instr]. *)
let get_function instr = instr |> Llvm.instr_parent |> Llvm.block_parent

(** [get_instr_before wide instr] returns a instr before [i].
    If [wide], searches all instructions in the ancestral function of [i].
    Else, searches instructions only within the parental block of [i]. *)
let get_instr_before ~wide instr =
  let is_interesting i =
    (* we are looking for non-terminator assignment instruction *)
    (not (is_terminator i)) && i |> instr_opcode |> is_assignment
  in

  if wide then
    let rec aux res rev_pos =
      match rev_pos with
      | At_start b -> (
          (* For wide search, also investigate preceding blocks in the function *)
          match block_pred b with
          | At_start _ -> None
          | After b -> aux res (instr_end b))
      | After i -> if is_interesting i then Some i else aux res (instr_pred i)
    in
    aux None (instr_pred instr)
  else
    let rec aux res rev_pos =
      match rev_pos with
      (* For narrow search, only look into the block which contains the instruction *)
      | At_start _ -> None
      | After i -> if is_interesting i then Some i else aux res (instr_pred i)
    in
    let f = instr |> get_function in
    let entry = entry_block f in
    aux None (instr_end entry)

(** [get_instrs_before wide i] returns a list of all instrs before [i].
    If [wide], includes all instructions in the ancestral function of [i].
    Else, includes instructions only within the parental block of [i]. *)
let get_instrs_before ~wide i =
  let rec aux accu rev_pos =
    match rev_pos with
    | At_start b ->
        if wide then
          match block_pred b with
          | At_start _ -> accu
          | After b -> aux accu (instr_end b)
        else accu
    | After i -> aux (i :: accu) (instr_pred i)
  in
  aux [] (instr_pred i)

(** [list_filter_type ty vl] returns
    a filtered version of [vl]; only llvalues with type [ty] remains. *)
let list_filter_type ty vl = List.filter (fun v -> type_of v = ty) vl

(** [get_blocks_after bb] returns
    a list of all blocks after [bb] in its parent function. *)
let get_blocks_after bb =
  let rec aux rev_pos accu =
    match rev_pos with
    | After block ->
        if block = bb then accu else aux (block_pred block) (block :: accu)
    | At_start _ -> failwith "NEVER OCCUR"
  in
  aux (bb |> block_parent |> block_end) []

(** [choose_function llm] returns an arbitrary function in [llm]. *)
let choose_function llm =
  let rec aux = function
    | Before f -> if is_declaration f then aux (function_succ f) else f
    | At_end _ -> failwith "No function defined"
  in
  aux (function_begin llm)

(** [replace_hard before after] replaces
    all uses of [before] to [after] and delete [before]. *)
let replace_hard before after =
  replace_all_uses_with before after;
  delete_instruction before

module OpcodeClass = struct
  exception Improper_class

  type t = TER | BINARY | MEM | CAST | CMP | PHI | OTHER

  (* use these lists to mark progress *)
  let ter_list = [ Opcode.Ret; Br ]

  let binary_list =
    [
      Opcode.Add;
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

  let mem_list = [ Opcode.Alloca; Load; Store ]
  let cast_list = [ Opcode.Trunc; ZExt; SExt ]
  let cmp_list = [ Opcode.ICmp ]
  let phi_list = [ Opcode.PHI ]
  let other_list = []

  (* helper for cmp instruction *)
  let cmp_kind = [ Icmp.Eq; Ne; Ugt; Uge; Ult; Ule; Sgt; Sge; Slt; Sle ]

  let total_list =
    ter_list @ binary_list @ mem_list @ cast_list @ cmp_list @ phi_list
    @ other_list

  let classify = function
    | Opcode.Ret | Br -> TER
    | Add | Sub | Mul | UDiv | SDiv | URem | SRem | Shl | LShr | AShr | And | Or
    | Xor ->
        BINARY
    | Alloca | Load | Store -> MEM
    | Trunc | ZExt | SExt -> CAST
    | ICmp -> CMP
    | PHI -> PHI
    | _ -> OTHER

  let opcls_of instr = instr |> instr_opcode |> classify
  let is_of instr cls = opcls_of instr = cls

  let oplist_of = function
    | TER -> ter_list
    | BINARY -> binary_list
    | MEM -> mem_list
    | CAST -> cast_list
    | CMP -> cmp_list
    | PHI -> phi_list
    | OTHER -> other_list

  let random_op_of opcls = opcls |> oplist_of |> AUtil.choose_random

  (** [random_opcode ()] returns a random opcode. *)
  let random_opcode () = AUtil.choose_random total_list

  (** [random_opcode_except opcode] returns another random opcode in its class.
        If [opcode] is the only one in its class, returns [opcode]. *)
  let random_opcode_except opcode =
    let l =
      List.filter (fun x -> x <> opcode) (opcode |> classify |> oplist_of)
    in
    match l with [] -> opcode | _ -> AUtil.choose_random l

  let random_cmp () = AUtil.choose_random cmp_kind

  let build_binary opcode o0 o1 llb =
    (match opcode with
    | Opcode.Add -> build_add
    | Sub -> build_sub
    | Mul -> build_mul
    | UDiv -> build_udiv
    | SDiv -> build_sdiv
    | URem -> build_urem
    | SRem -> build_srem
    | Shl -> build_shl
    | LShr -> build_lshr
    | AShr -> build_ashr
    | And -> build_and
    | Or -> build_or
    | Xor -> build_xor
    | _ -> raise Improper_class)
      o0 o1 "" llb

  let build_cast opcode o ty llb =
    (match opcode with
    | Opcode.Trunc -> build_trunc
    | ZExt -> build_zext
    | SExt -> build_sext
    | _ -> raise Improper_class)
      o ty "" llb

  let build_cmp icmp o0 o1 llb = build_icmp icmp o0 o1 "" llb

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
    | Opcode.Add | Sub | Mul | Shl -> true
    | _ -> false

  let can_be_exact = function
    | Opcode.SDiv | UDiv | AShr | LShr -> true
    | _ -> false

  external set_nuw_raw : bool -> llvalue -> unit = "llvm_set_nuw"
  external set_nsw_raw : bool -> llvalue -> unit = "llvm_set_nsw"
  external set_exact_raw : bool -> llvalue -> unit = "llvm_set_exact"
  external is_nuw_raw : llvalue -> bool = "llvm_is_nuw"
  external is_nsw_raw : llvalue -> bool = "llvm_is_nsw"
  external is_exact_raw : llvalue -> bool = "llvm_is_exact"

  let guard_set prereq f flag instr =
    if instr |> instr_opcode |> prereq then f flag instr
    else raise Unsupported_Flag

  let set_nuw = guard_set can_overflow set_nuw_raw
  let set_nsw = guard_set can_overflow set_nsw_raw
  let set_exact = guard_set can_be_exact set_exact_raw

  let guard_is prereq f instr =
    if instr |> instr_opcode |> prereq then f instr else raise Unsupported_Flag

  let is_nuw = guard_is can_overflow is_nuw_raw
  let is_nsw = guard_is can_overflow is_nsw_raw
  let is_exact = guard_is can_be_exact is_exact_raw
end

(* CFG MODIFYING MUTATION HELPERS *)

module CFG_Modifier = struct
  (** [make_conditional llctx instr] substitutes
    an unconditional branch instruction [instr]
    into always-true conditional branch instruction.
    (Block instructions are cloned between both destinations, except names.)
    Returns the conditional branch instruction. *)
  let make_conditional llctx instr =
    match instr |> get_branch |> Option.get with
    | `Unconditional target_block ->
        let block = instr_parent instr in
        let fbb = append_block llctx "" (block_parent block) in
        move_block_after target_block fbb;
        iter_instrs
          (fun i ->
            insert_into_builder (instr_clone i) "" (builder_at_end llctx fbb))
          target_block;
        delete_instruction instr;
        build_cond_br
          (const_int (i1_type llctx) 1)
          target_block fbb
          (builder_at_end llctx block)
    | `Conditional _ -> failwith "Conditional branch already"

  (** [make_unconditional llctx instr] substitutes
    a conditional branch instruction [instr]
    into unconditional branch instruction targets for true-branch.
    (False branch block remains in the module; just not used by the branch.)
    Returns the unconditional branch instruction. *)
  let make_unconditional llctx instr =
    match instr |> get_branch |> Option.get with
    | `Conditional (_, tbb, _) ->
        let block = instr_parent instr in
        delete_instruction instr;
        build_br tbb (builder_at_end llctx block)
    | `Unconditional _ -> failwith "Unconditional branch already"

  (** [set_unconditional_dest llctx instr bb] sets
    the destinations of the unconditional branch instruction [instr] to [bb].
    Returns the new instruction. *)
  let set_unconditional_dest llctx instr bb =
    match instr |> get_branch |> Option.get with
    | `Unconditional _ ->
        let result = build_br bb (builder_before llctx instr) in
        delete_instruction instr;
        result
    | `Conditional _ -> failwith "Conditional branch"

  (** [set_conditional_dest llctx instr tbb fbb] sets
    the destinations of the conditional branch instruction [instr].
    If given as [None], retains the original destination.
    Returns the new instruction. *)
  let set_conditional_dest llctx instr tbb fbb =
    match instr |> get_branch |> Option.get with
    | `Conditional (cond, old_tbb, old_fbb) ->
        let result =
          build_cond_br cond
            (match tbb with Some tbb -> tbb | None -> old_tbb)
            (match fbb with Some fbb -> fbb | None -> old_fbb)
            (builder_before llctx instr)
        in
        delete_instruction instr;
        result
    | `Unconditional _ -> failwith "Unconditional branch"

  (** [split_block llctx loc] splits the parent block of [loc] into two blocks
    and links them by unconditional branch.
    [loc] becomes the first instruction of the latter block.
    Returns the former block. *)
  let split_block llctx loc =
    let block = instr_parent loc in
    let new_block = insert_block llctx "" block in
    let builder = builder_at_end llctx new_block in

    (* initial setting *)
    let dummy = build_unreachable builder in
    position_before dummy builder;

    (* migrating instructions *)
    let rec aux () =
      match instr_begin block with
      | Before i when i = loc -> ()
      | Before i ->
          let i_clone = instr_clone i in
          insert_into_builder i_clone "" builder;
          replace_hard i i_clone;
          aux ()
      | At_end _ -> failwith "NEVER OCCUR"
    in
    aux ();

    (* modifying all branches targets original block *)
    iter_blocks
      (fun b ->
        let ter = b |> block_terminator |> Option.get in
        let succs = ter |> successors in
        Array.iteri
          (fun i elem -> if elem = block then set_successor ter i new_block)
          succs)
      (loc |> instr_parent |> block_parent);

    (* linking and cleaning *)
    build_br block builder |> ignore;
    delete_instruction dummy;

    (* finally done *)
    new_block
end

module LLVMap = Map.Make (struct
  type t = llvalue

  (* same llvalues sometimes map to other key *)
  let compare = compare
end)

module LLBMap = Map.Make (struct
  type t = llbasicblock

  (* same llbasicblocks sometimes map to other key *)
  let compare llb0 llb1 =
    compare
      (llb0 |> value_of_block |> value_name)
      (llb1 |> value_of_block |> value_name)
end)

let block_name block = block |> value_of_block |> value_name

(** [reset_var_names f] sets names of all parameters and instructions in
    function [f]. This is specially useful when we have to assure all values
    have own names. *)
let reset_var_names f =
  let aux () =
    let name i = "val" ^ string_of_int i in
    let start =
      Array.fold_left
        (fun accu param ->
          set_value_name (name accu) param;
          accu + 1)
        0 (params f)
    in
    fold_left_all_instr
      (fun accu i ->
        if i |> type_of |> classify_type <> Void then (
          set_value_name (name accu) i;
          accu + 1)
        else accu)
      start f
    |> ignore
  in

  (* had better call this twice for prettier names;
     once is enough, so if this makes performance issue, erase one *)
  () |> aux |> aux

(* THIS MODULE IS TO-BE-UPDATED. *)
module ChangeRetVal = struct
  let find_block_by_name f name =
    match
      fold_left_blocks
        (fun accu block ->
          if Option.is_some accu then accu
          else if block_name block = name then Some block
          else accu)
        None f
    with
    | Some block -> block
    | None -> failwith ("No block named " ^ name)

  let migrate_llv llv_old ty_expected link_instr =
    if is_constant llv_old then
      match llv_old |> type_of |> classify_type with
      | Integer -> (
          if is_poison llv_old then poison ty_expected
          else if is_undef llv_old then undef ty_expected
          else
            try
              match classify_type ty_expected with
              | Integer ->
                  const_int ty_expected
                    (llv_old |> int64_of_const |> Option.get |> Int64.to_int)
              | Vector ->
                  let el_ty = element_type ty_expected in
                  let vec_size = vector_size ty_expected in
                  let llv_arr =
                    Array.make vec_size
                      (const_int el_ty
                         (llv_old
                         |> int64_of_const
                         |> Option.get
                         |> Int64.to_int))
                  in
                  const_vector llv_arr
              | _ -> failwith "Unsupported type migration"
            with _ -> exit 1)
      | Pointer -> const_null ty_expected
      | Vector -> (
          try
            match classify_type ty_expected with
            | Integer ->
                const_int ty_expected
                  (aggregate_element llv_old 0
                  |> Option.get
                  |> int64_of_const
                  |> Option.get
                  |> Int64.to_int)
            | Vector ->
                let el_ty = element_type ty_expected in
                let vec_size = vector_size ty_expected in
                let llv_arr =
                  Array.make vec_size
                    (const_int el_ty
                       (aggregate_element llv_old 0
                       |> Option.get
                       |> int64_of_const
                       |> Option.get
                       |> Int64.to_int))
                in
                const_vector llv_arr
            | _ -> failwith "Unsupported type migration"
          with _ -> exit 1)
      | _ -> failwith "Unsupported type migration"
    else LLVMap.find llv_old link_instr

  let migrate_llb llb_old link_block = LLBMap.find llb_old link_block

  let copy_instr_with_new_retval llctx llb instr_old link_instr link_block
      f_new_type =
    (* values *)
    let f = llb |> insertion_block |> block_parent in
    let name = value_name instr_old in
    let opc = instr_opcode instr_old in
    let migrate_llv llv ty_expect = migrate_llv llv ty_expect link_instr in
    let migrate_llb llb = migrate_llb llb link_block in

    (* copying instruction *)
    let instr_new =
      if OpcodeClass.classify opc = BINARY then (
        let ty_expect = type_of instr_old in
        let instr_new =
          OpcodeClass.build_binary opc
            (migrate_llv (operand instr_old 0) ty_expect)
            (migrate_llv (operand instr_old 1) ty_expect)
            llb
        in
        set_value_name name instr_new;
        instr_new)
      else
        match opc with
        | Ret ->
            let rec build_ret' loc =
              let target = get_instr_before ~wide:true loc in
              match target with
              | Some i -> (
                  match LLVMap.find_opt i link_instr with
                  | Some new_i ->
                      if f_new_type = type_of new_i then build_ret new_i llb
                      else build_ret' i
                  | None -> build_ret' i)
              | None ->
                  let ty_ret = f |> type_of |> return_type |> return_type in
                  if ty_ret = void_type llctx then build_ret_void llb
                  else build_ret (migrate_llv (operand instr_old 0) ty_ret) llb
            in
            build_ret' instr_old
        | Br -> (
            let find_block block_old =
              find_block_by_name f (block_name block_old)
            in
            match get_branch instr_old with
            | Some (`Conditional (cond, tb, fb)) ->
                build_cond_br
                  (migrate_llv cond (i1_type llctx))
                  (find_block tb) (find_block fb) llb
            | Some (`Unconditional dest) -> build_br (find_block dest) llb
            | None -> failwith "Not supporting other kind of branches")
        | Alloca ->
            let allocate_type = get_allocated_type instr_old in
            build_alloca allocate_type name llb
        | Load ->
            let opd = operand instr_old 0 in
            build_load (type_of instr_old)
              (migrate_llv opd (type_of instr_old))
              name llb
        | Store -> (
            let opd0 = operand instr_old 0 in
            let opd1 = operand instr_old 1 in
            match (is_constant opd0, is_constant opd1) with
            | false, false | false, true ->
                let ty_expcted_opd0 = type_of opd0 in
                build_store
                  (migrate_llv opd0 ty_expcted_opd0)
                  (migrate_llv opd1 (pointer_type llctx))
                  llb
            | true, false ->
                let ty_expcted_opd0 = type_of opd0 in
                let ty_expcted_opd1 = type_of opd1 in
                build_store
                  (migrate_llv opd0 ty_expcted_opd0)
                  (migrate_llv opd1 ty_expcted_opd1)
                  llb
            | true, true ->
                (* just do anything *)
                build_store
                  (const_int (i32_type llctx) 0)
                  (const_null (pointer_type llctx))
                  llb)
        (* below three cast instructions can be interchanged, or even omitted *)
        | Trunc | ZExt | SExt ->
            let opd = operand instr_old 0 in
            let ty_tgt = type_of instr_old in
            let ty_src = type_of opd in
            let opd' = migrate_llv opd ty_src in
            let bw_tgt = integer_bitwidth ty_tgt in
            let bw_src = integer_bitwidth ty_src in
            if bw_src < bw_tgt then
              if opc = ZExt then build_zext opd' ty_tgt name llb
              else build_sext opd' ty_tgt name llb
            else if bw_src > bw_tgt then build_trunc opd' ty_tgt name llb
            else build_add opd' (const_int (type_of opd') 0) name llb
        | ICmp ->
            let opd0 = operand instr_old 0 in
            let opd1 = operand instr_old 1 in
            let ty_expect =
              match (is_constant opd0, is_constant opd1) with
              | false, false | false, true -> type_of opd0
              | true, false -> type_of opd1
              | true, true -> type_of opd1
            in
            build_icmp
              (icmp_predicate instr_old |> Option.get)
              (migrate_llv opd0 ty_expect)
              (migrate_llv opd1 ty_expect)
              name llb
        | PHI ->
            let incoming = Llvm.incoming instr_old in
            let new_incoming =
              List.map
                (fun (llv, llb) ->
                  (migrate_llv llv (type_of llv), migrate_llb llb))
                incoming
            in
            build_phi new_incoming name llb
        | Call ->
            let num_operands = num_operands instr_old in
            let calling_fn = operand instr_old (num_operands - 1) in
            let opds =
              let rec loop accu i =
                if i >= num_operands - 1 then accu
                else
                  let opd = operand instr_old i in
                  loop (migrate_llv opd (type_of opd) :: accu) (i + 1)
              in
              loop [] 0 |> Array.of_list
            in
            build_call
              (function_type (type_of instr_old)
                 (Array.map (fun p -> type_of p) opds))
              calling_fn opds name llb
        | ExtractValue ->
            let opd0 = operand instr_old 0 in
            let idx = Array.get (indices instr_old) 0 in
            build_extractvalue (migrate_llv opd0 (type_of opd0)) idx name llb
        | GetElementPtr ->
            (* let opd0 = operand instr_old 0 in
               let indices =
                 num_operands instr_old - 1
                 |> (Fun.flip List.init) (fun i -> operand instr_old (i + 1))
               in *)
            failwith "Not supported instruction"
        | _ -> failwith "Not supported instruction"
    in
    LLVMap.add instr_old instr_new link_instr

  let copy_block_with_new_retval llctx block_old block_new link_instr link_block
      f_new_type =
    (* assert block_new is empty *)
    let llb = builder_at llctx (instr_begin block_new) in
    fold_left_instrs
      (fun link_instr instr_old ->
        copy_instr_with_new_retval llctx llb instr_old link_instr link_block
          f_new_type)
      link_instr block_old

  let copy_function_with_new_retval llctx f_old f_new f_new_type =
    (* assert f_new is empty except prescence of entry block *)
    let link_instr_init =
      (* NOTE: params_new is longer than params_old *)
      let params_new = params f_new in
      params f_old
      |> Array.mapi (fun i param_old -> (param_old, params_new.(i)))
      |> Array.to_seq
      |> LLVMap.of_seq
    in

    (* have to build blocks first (for some instructions) *)
    let entry_new = entry_block f_new in
    let blocks_old = basic_blocks f_old in
    let rec loop prev_block i =
      if i >= Array.length blocks_old then ()
      else
        let block_new =
          insert_block llctx (block_name blocks_old.(i)) entry_new
        in
        move_block_after prev_block block_new;
        loop block_new (i + 1)
    in
    loop entry_new 1;

    (* start copy *)
    let blocks_new = basic_blocks f_new in
    let rec loop link_instr link_block i =
      if i >= Array.length blocks_old then ()
      else
        let block_old = blocks_old.(i) in
        let block_new = blocks_new.(i) in
        let link_block = LLBMap.add block_old block_new link_block in
        let link_instr =
          copy_block_with_new_retval llctx block_old block_new link_instr
            link_block f_new_type
        in
        loop link_instr link_block (i + 1)
    in

    loop link_instr_init LLBMap.empty 0
end

let hash_llm llm = string_of_llmodule llm |> String.trim |> Hashtbl.hash

module LLModuleSet : sig
  type t

  val add : llmodule -> t -> t
  val mem : llmodule -> t -> bool
  val get_new_name : llmodule -> t -> string option
  val cardinal : t -> int
  val empty : t
end = struct
  include Set.Make (Int)

  let add llm set = add (hash_llm llm) set
  let mem llm set = mem (hash_llm llm) set

  let get_new_name llm set =
    let llm_hash = hash_llm llm in
    match find_opt llm_hash set with
    | Some _ -> None
    | None -> Format.sprintf "id:%010d.ll" llm_hash |> Option.some
end
