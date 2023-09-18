open IR
open Util.OpHelper.OpcodeClass

(* INSTANTIATION: Connects LLVM and Pattern IR *)
(* Here, 'instance' means LLModule of a single function. *)
type instance_t = Llvm.llmodule

(** [run name pat] returns all instances of the given pattern [pat].
    Its function name is [name]. *)
let run name pat : instance_t list =
  let module ParamMap = Map.Make (String) in
  let llctx = Llvm.create_context () in
  let i1 = Llvm.i1_type llctx in
  let i32 = Llvm.i32_type llctx in

  (* let i64 = Llvm.i64_type llctx in *)

  (* find all variables in the pattern *)
  let rec number_vars m p =
    match p with
    | Var name ->
        if ParamMap.mem name m then m
        else ParamMap.add name (ParamMap.cardinal m) m
    | UnOp (_, v) -> number_vars m v
    | BinOp (_, _, lhs, rhs) -> number_vars (number_vars m lhs) rhs
    | _ -> m
  in
  let param_idx_map = number_vars ParamMap.empty pat in

  (* define the function *)
  let llm_original = Llvm.create_module llctx "test" in
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
  let f =
    Llvm.define_function name
      (Llvm.function_type ret_type
         (Array.make (ParamMap.cardinal param_idx_map) i32))
      llm_original
  in

  (* rename parameters *)
  ParamMap.iter
    (fun name idx ->
      let llv = Llvm.param f idx in
      Llvm.set_value_name name llv)
    param_idx_map;

  (* cloning helpers *)
  let func_of llm =
    match Llvm.function_begin llm with
    | Llvm.Before f -> f
    | _ -> failwith "NEVER OCCUR"
  in
  let builder_end llm =
    llm |> func_of |> Llvm.entry_block |> Llvm.builder_at_end llctx
  in

  (* DUMMY INSTRUCTION FOR PREVENTING CRASH DURING CLONING *)
  Llvm.build_unreachable (builder_end llm_original) |> ignore;
  let ur_of llm =
    llm |> func_of |> Llvm.entry_block |> Llvm.block_terminator |> Option.get
  in
  let builder_ur llm = llm |> ur_of |> Llvm.builder_before llctx in

  (* constants *)
  let const_of_i32 = Llvm.const_int i32 in
  let ints = [ 0; 1; 2; 1073741825; -1; -5; -9 ] in
  let llvs_possible cstr = ints |> List.filter cstr |> List.map const_of_i32 in

  (* names of instrs are preserved across clones, although they might differ *)
  let renew_llv name llv_def llm_new =
    if name = "" then llv_def
    else
      match ParamMap.find_opt name param_idx_map with
      | Some idx -> Llvm.param (func_of llm_new) idx
      | None ->
          let bb = llm_new |> func_of |> Llvm.entry_block in
          let rec aux = function
            | Llvm.Before instr ->
                if name = Llvm.value_name instr then instr
                else instr |> Llvm.instr_succ |> aux
            | Llvm.At_end _ -> raise Not_found
          in
          aux (Llvm.instr_begin bb)
  in

  (* postorder traversal involving instruction generation *)
  let rec traverse pat llm_curr : string * (Llvm.llvalue * Llvm.llmodule) list =
    match pat with
    | Any ->
        (* TODO: var is also allowed here -- m_OneUse? *)
        ( "",
          List.fold_left
            (fun accu llv ->
              (llv, Llvm_transform_utils.clone_module llm_curr) :: accu)
            []
            (llvs_possible (Fun.const true)) )
    | Const (_, cstr) -> (
        match cstr with
        | IntCstr cstr ->
            ( "",
              List.fold_left
                (fun accu llv ->
                  (llv, Llvm_transform_utils.clone_module llm_curr) :: accu)
                [] (llvs_possible cstr) )
        | FloatCstr _ -> failwith "Not implemented")
    | Var name ->
        ( name,
          [
            ( Llvm.param (func_of llm_curr) (ParamMap.find name param_idx_map),
              llm_curr );
          ] )
    | UnOp _ -> failwith "Not implemented"
    | BinOp (binop, _, lhs_pat, rhs_pat) ->
        let lhs_name, lhs_candidates = traverse lhs_pat llm_curr in
        let lhs_llvs = List.map fst lhs_candidates in
        let lhs_llms = List.map snd lhs_candidates in
        let foo =
          List.fold_left2
            (fun accu lhs_llv lhs_llm ->
              let rhs_name, rhs_candidates = traverse rhs_pat lhs_llm in
              let rhs_llvs = List.map fst rhs_candidates in
              let rhs_llms = List.map snd rhs_candidates in
              List.fold_left2
                (fun accu rhs_llv rhs_llm ->
                  let llm_binop = Llvm_transform_utils.clone_module rhs_llm in
                  let lhs = renew_llv lhs_name lhs_llv llm_binop in
                  let rhs = renew_llv rhs_name rhs_llv llm_binop in
                  let opcode_llvm =
                    binop |> string_of_binop |> Util.LUtil.opcode_of_string
                  in
                  match classify opcode_llvm with
                  | ARITH ->
                      let instr_new =
                        build_arith opcode_llvm lhs rhs (builder_ur llm_binop)
                      in
                      (instr_new, llm_binop) :: accu
                  | LOGIC ->
                      let instr_new =
                        build_logic opcode_llvm lhs rhs (builder_ur llm_binop)
                      in
                      (instr_new, llm_binop) :: accu
                  | CMP ->
                      List.fold_left
                        (fun accu kind ->
                          let llm_cmp =
                            Llvm_transform_utils.clone_module llm_binop
                          in
                          let lhs = renew_llv lhs_name lhs_llv llm_cmp in
                          let rhs = renew_llv rhs_name rhs_llv llm_cmp in
                          let instr_new =
                            build_cmp kind lhs rhs (builder_ur llm_cmp)
                          in
                          (instr_new, llm_cmp) :: accu)
                        accu cmp_kind
                  | _ -> failwith "Not implemented")
                accu rhs_llvs rhs_llms)
            [] lhs_llvs lhs_llms
        in
        (foo |> List.hd |> fst |> Llvm.value_name, foo)
  in

  (* finally, replace unreachables to return *)
  let llms = traverse pat llm_original |> snd |> List.map snd in
  List.map
    (fun llm ->
      let ur = ur_of llm in
      Llvm.build_ret
        (match Llvm.instr_pred ur with
        | After instr -> instr
        | _ -> failwith "NEVER OCCUR")
        (builder_end llm)
      |> ignore;
      Llvm.delete_instruction ur;
      llm)
    llms
