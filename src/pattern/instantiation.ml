open IR

(* INSTANTIATION: Connects LLVM and Pattern IR *)
(* Here, 'instance' means LLModule of a single function. *)
type instance_t = Llvm.llmodule

(** [run name pat] returns an instance of the given pattern [pat].
    Its function name is [name]. *)
let run name pat =
  let module ParamMap = Map.Make (String) in
  let llctx = Llvm.create_context () in
  let llm = Llvm.create_module llctx "test" in
  let i32 = Llvm.i32_type llctx in

  (* find all variables in the pattern *)
  let rec number_vars m p =
    match p with
    | Var name ->
        if ParamMap.mem name m then m
        else ParamMap.add name (ParamMap.cardinal m) m
    | Operator (_, sps) -> List.fold_left number_vars m sps
    | _ -> m
  in
  let param_idx_map = number_vars ParamMap.empty pat in

  (* define the function *)
  let f =
    Llvm.define_function name
      (Llvm.function_type i32
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
    | Const (_, cstr) ->
        if cstr (-1) then const_of (-1)
        else if cstr 0 then const_of 0
        else if cstr 1 then const_of 1
        else raise Not_found
    | Var name -> ParamMap.find name param_llv_map
    | Operator (opcode_llvm, sps) -> (
        let sp_instances = List.map aux sps in
        let opcode_llvm =
          opcode_llvm |> string_of_opcode |> Util.LUtil.opcode_of_string
        in
        let open Util.OpcodeClass in
        match classify opcode_llvm with
        | ARITH ->
            build_arith opcode_llvm (List.nth sp_instances 0)
              (List.nth sp_instances 1) builder
        | LOGIC ->
            build_logic opcode_llvm (List.nth sp_instances 0)
              (List.nth sp_instances 1) builder
        | _ -> failwith "Not implemented")
  in
  Llvm.build_ret (aux pat) builder |> ignore;
  llm
