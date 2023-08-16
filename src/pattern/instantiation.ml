open IR
open Util.OpcodeClass

(* INSTANTIATION: Connects LLVM and Pattern IR *)
(* Here, 'instance' means LLModule of a single function. *)
type instance_t = Llvm.llmodule

(** [run name pat] returns an instance of the given pattern [pat].
    Its function name is [name]. *)
let run name pat =
  let module ParamMap = Map.Make (String) in
  let llctx = Llvm.create_context () in
  let llm = Llvm.create_module llctx "test" in
  let i1 = Llvm.i1_type llctx in
  let i32 = Llvm.i32_type llctx in

  (* find all variables in the pattern *)
  let rec number_vars m p =
    match p with
    | Var name ->
        if ParamMap.mem name m then m
        else ParamMap.add name (ParamMap.cardinal m) m
    | BinOp (_, _, lhs, rhs) -> number_vars (number_vars m lhs) rhs
    | _ -> m
  in
  let param_idx_map = number_vars ParamMap.empty pat in
  (* define the function *)
  let f =
    let ret_type =
      match pat with
      | BinOp (binop, _, _, _) -> (
          match
            binop |> string_of_binop |> Util.LUtil.opcode_of_string |> classify
          with
          | ARITH | LOGIC -> i32
          | CMP -> i1
          | _ -> failwith "Not implemented")
      | _ -> failwith "Return is not a instruction"
    in
    Llvm.define_function name
      (Llvm.function_type ret_type
         (Array.make (ParamMap.cardinal param_idx_map) i32))
      llm
  in
  let param_llv_map =
    ParamMap.mapi
      (fun param idx ->
        let llv = Llvm.param f idx in
        Llvm.set_value_name param llv;
        llv)
      param_idx_map
  in
  let builder = Llvm.builder_at_end llctx (Llvm.entry_block f) in

  (* postorder traversal involving instruction generation *)
  let const_of = Llvm.const_int i32 in
  let rec aux = function
    | Any -> Llvm.const_int i32 0
    | Const (_, cstr) -> (
        match cstr with
        | IntCstr cstr ->
            if cstr (-1) then const_of (-1)
            else if cstr 0 then const_of 0
            else if cstr 1 then const_of 1
            else raise Not_found
        | FloatCstr _ -> failwith "Not implemented")
    | Var name -> ParamMap.find name param_llv_map
    | BinOp (binop, _, lhs, rhs) -> (
        let lhs_instance = aux lhs in
        let rhs_instance = aux rhs in
        let opcode_llvm =
          binop |> string_of_binop |> Util.LUtil.opcode_of_string
        in
        match classify opcode_llvm with
        | ARITH -> build_arith opcode_llvm lhs_instance rhs_instance builder
        | LOGIC -> build_logic opcode_llvm lhs_instance rhs_instance builder
        | CMP -> build_cmp Llvm.Icmp.Ne lhs_instance rhs_instance builder
        | _ -> failwith "Not implemented")
  in

  Llvm.build_ret (aux pat) builder |> ignore;
  llm
