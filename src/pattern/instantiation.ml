open IR
open Util.OpcodeClass

(* INSTANTIATION: Connects LLVM and Pattern IR *)
(* Here, 'instance' means LLModule of a single function. *)
type instance_t = Llvm.llmodule

(* type for candidate of a pattern;
   the first tuple represents whether recently referred values are variables. *)
type cand_t = (Llvm.llvalue option * Llvm.llvalue option) * Llvm.llmodule

(** [run name pat] returns all instances of the given pattern [pat].
    Its function name is [name]. *)
let run name pat : instance_t list =
  let module ParamMap = Map.Make (String) in
  let llctx = Llvm.create_context () in
  let i1 = Llvm.i1_type llctx in
  let i32 = Llvm.i32_type llctx in
  let i64 = Llvm.i64_type llctx in

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

  (* renaming parameters *)
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
  let cands_int = [ 0; 1; 2; 1073741825; -1; -5; -9 ] in
  let llvs_possible cstr =
    cands_int |> List.filter cstr |> List.map const_of_i32
  in

  (* helpers for candidates *)
  let buffer_of = fst in
  let llm_of = snd in
  let push_buffer incoming cand = (Some incoming, cand |> buffer_of |> fst) in
  let push_and_keep (incoming : Llvm.llvalue) (cand : cand_t) : cand_t =
    (push_buffer incoming cand, llm_of cand)
  in

  (* postorder traversal involving instruction generation *)
  let rec traverse pat cands =
    let fold_cand f = List.fold_left f [] cands in
    print_endline "fuck";
    match pat with
    | Any ->
        (* TODO: var is also allowed here -- m_OneUse? *)
        fold_cand (fun accu cand ->
            List.fold_left
              (fun accu llv -> push_and_keep llv cand :: accu)
              accu
              (llvs_possible (Fun.const true)))
    | Const (_, cstr) -> (
        match cstr with
        | IntCstr cstr ->
            fold_cand (fun accu cand ->
                List.fold_left
                  (fun accu llv -> push_and_keep llv cand :: accu)
                  accu (llvs_possible cstr))
        | FloatCstr _ -> failwith "Not implemented")
    | Var name ->
        print_endline "fuck2";
        print_endline name;
        List.map
          (fun cand ->
            let llm = llm_of cand in
            push_and_keep
              (Llvm.param (func_of llm) (ParamMap.find name param_idx_map))
              cand)
          cands
    | UnOp (unop, v) ->
        let cands = traverse v cands in
        List.map
          (fun cand ->
            let llm = cand |> llm_of |> Llvm_transform_utils.clone_module in
            let buffer = buffer_of cand in
            let builder = builder_ur llm in

            (* find corresponding cloned value *)
            let last_instr =
              match Llvm.instr_pred (ur_of llm) with
              | After instr -> Some instr
              | _ -> None
            in

            let v_bef = buffer |> fst |> Option.get in
            let v_aft =
              match Llvm.classify_value v_bef with
              | Argument ->
                  Llvm.param (func_of llm)
                    (ParamMap.find (Llvm.value_name v_bef) param_idx_map)
              | Instruction _ -> Option.get last_instr
              | _ -> v_bef
            in
            (* add new instruction *)
            let opcode_llvm =
              unop |> string_of_unop |> Util.LUtil.opcode_of_string
            in
            let instr_new =
              match classify opcode_llvm with
              | CAST -> build_cast opcode_llvm v_aft i64 builder
              | _ -> failwith "Not implemented"
            in
            ((Some instr_new, fst buffer), llm))
          cands
    | BinOp (binop, _, lhs, rhs) ->
        let cands = traverse rhs (traverse lhs cands) in
        List.fold_left
          (fun accu cand ->
            let buffer = buffer_of cand in

            (* helpers for cloned modules *)
            let last_instr llm =
              match Llvm.instr_pred (ur_of llm) with
              | After instr -> Some instr
              | _ -> None
            in
            let last2_instr llm =
              match last_instr llm with
              | Some last_instr -> (
                  match Llvm.instr_pred last_instr with
                  | After instr -> Some instr
                  | _ -> None)
              | None -> None
            in

            (* helpers finding corresponding cloned value *)
            let lhs = buffer |> snd |> Option.get in
            let rhs = buffer |> fst |> Option.get in
            let renew_rhs llm =
              match Llvm.classify_value rhs with
              | Argument ->
                  Llvm.param (func_of llm)
                    (ParamMap.find (Llvm.value_name rhs) param_idx_map)
              | Instruction _ -> (
                  match Llvm.classify_value lhs with
                  | Instruction _ -> llm |> last2_instr |> Option.get
                  | _ -> llm |> last_instr |> Option.get)
              | _ -> rhs
            in

            let renew_lhs llm =
              match Llvm.classify_value lhs with
              | Argument ->
                  Llvm.param (func_of llm)
                    (ParamMap.find (Llvm.value_name lhs) param_idx_map)
              | Instruction _ -> llm |> last_instr |> Option.get
              | _ -> lhs
            in

            (* add new instruction *)
            let opcode_llvm =
              binop |> string_of_binop |> Util.LUtil.opcode_of_string
            in
            match classify opcode_llvm with
            | ARITH ->
                let llm = cand |> llm_of |> Llvm_transform_utils.clone_module in
                let instr_new =
                  build_arith opcode_llvm (renew_lhs llm) (renew_rhs llm)
                    (builder_ur llm)
                in
                ((Some instr_new, fst buffer), llm) :: accu
            | LOGIC ->
                let llm = cand |> llm_of |> Llvm_transform_utils.clone_module in
                let instr_new =
                  build_logic opcode_llvm (renew_lhs llm) (renew_rhs llm)
                    (builder_ur llm)
                in
                ((Some instr_new, fst buffer), llm) :: accu
            | CMP ->
                List.fold_left
                  (fun accu kind ->
                    let llm =
                      cand |> llm_of |> Llvm_transform_utils.clone_module
                    in
                    let instr_new =
                      build_cmp kind (renew_lhs llm) (renew_rhs llm)
                        (builder_ur llm)
                    in
                    ((Some instr_new, fst buffer), llm) :: accu)
                  accu Util.OpcodeClass.cmp_kind
            | _ -> failwith "Not implemented")
          [] cands
  in
  (* finally, replace unreachables to return *)
  let llms = traverse pat [ ((None, None), llm_original) ] |> List.map snd in
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
