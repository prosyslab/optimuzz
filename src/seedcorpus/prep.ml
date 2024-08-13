open Util

let check_value_type_for_mutation llv =
  let ty = ALlvm.type_of llv in
  if String.starts_with ~prefix:"target" (ALlvm.string_of_lltype ty) then false
    (* else if
         String.starts_with ~prefix:"@" (ALlvm.string_of_llvalue llv)
         || String.starts_with ~prefix:"declare" (ALlvm.string_of_llvalue llv)
       then false *)
  else
    match ALlvm.classify_type ty with
    | Void | Half | Float | Double | Fp128 | Label | Integer | Function | Array
    | Metadata ->
        true
    | Vector when ty |> ALlvm.element_type |> ALlvm.classify_type = Integer ->
        true
    | Vector -> false
    | Pointer -> (
        try
          ignore
            (Str.search_forward
               (Str.regexp_string "inttoptr")
               (ALlvm.string_of_llvalue llv)
               0);
          false
        with Not_found ->
          llv |> ALlvm.type_of |> ALlvm.address_space = 0
          && (not (ALlvm.is_global_constant llv))
          && not (ALlvm.is_null llv))
    | _ -> false

let check_opc_for_mutation opc =
  if ALlvm.OpcodeClass.classify opc = UNSUPPORTED then false else true

let rec check_opd_for_mutation i llv res =
  if (not res) || i = ALlvm.num_operands llv then res
  else
    i
    |> ALlvm.operand llv
    |> check_value_type_for_mutation
    |> check_opd_for_mutation (i + 1) llv

let check_llv_for_mutation res llv =
  if not res then res
  else
    match ALlvm.classify_value llv with
    | Instruction opc ->
        opc |> check_opc_for_mutation |> check_opd_for_mutation 0 llv
    | _ -> check_value_type_for_mutation llv

let check_func_for_mutation f =
  let res = ALlvm.fold_left_params check_llv_for_mutation true f in
  let res = ALlvm.fold_left_all_instr check_llv_for_mutation res f in
  res

let check_llm_for_mutation llm =
  let res = ALlvm.fold_left_globals check_llv_for_mutation true llm in
  if not res then res
  else
    ALlvm.fold_left_functions
      (fun res f -> if not res then res else check_func_for_mutation f)
      res llm

let check_exist_ret func =
  let is_ret instr = ALlvm.instr_opcode instr = Ret in
  ALlvm.any_all_instr is_ret func

let rec redef_fn llctx f_old wide instr =
  let extra_param = [| ALlvm.i32_type llctx; ALlvm.i32_type llctx |] in
  let params_old = ALlvm.params f_old in
  let param_tys =
    Array.append (Array.map ALlvm.type_of params_old) extra_param
  in
  (* target: new instruction will returned.*)
  let target = ALlvm.get_instr_before ~wide instr in
  match target with
  | Some i ->
      if i = instr then true
      else if ALlvm.ChangeRetVal.check_target i then (
        let new_ret_ty = ALlvm.type_of i in
        let f_new =
          ALlvm.define_function ""
            (ALlvm.function_type new_ret_ty param_tys)
            (ALlvm.global_parent f_old)
        in

        (* copy function with new return value (target).*)
        ALlvm.ChangeRetVal.copy_blocks llctx f_old f_new;
        (try ALlvm.ChangeRetVal.migrate llctx f_old f_new i
         with _ -> ALlvm.delete_function f_new);

        true)
      else redef_fn llctx f_old wide i
  | None -> true

(* this function add the type-changed function in the module.
 * returns true if the original function should be deleted *)
let subst_ret llctx instr wide =
  let f_old = ALlvm.get_function instr in
  if ALlvm.ChangeRetVal.is_function_supported f_old then
    redef_fn llctx f_old wide instr
  else true

let rec clean_llm llctx wide llm =
  (* make llm clone*)
  let llm_clone = Llvm_transform_utils.clone_module llm in

  llm_clone
  |> ALlvm.fold_left_functions
       (fun accu f ->
         if not @@ ALlvm.ChangeRetVal.is_function_supported f then f :: accu
         else accu)
       []
  |> List.iter ALlvm.delete_function;

  (* delete functions which does not return *)
  let funcs_non_ret =
    llm_clone
    |> ALlvm.fold_left_functions
         (fun accu f -> if not @@ check_exist_ret f then f :: accu else accu)
         []
  in
  funcs_non_ret |> List.iter ALlvm.delete_function;

  (* delete functions which call non-llvm-intrinsic functions *)
  let funcs_including_calls =
    llm_clone
    |> ALlvm.fold_left_functions
         (fun accu f ->
           if
             f
             |> ALlvm.any_all_instr (fun instr ->
                    ALlvm.instr_opcode instr = Call
                    && not (ALlvm.is_llvm_intrinsic instr))
           then f :: accu
           else accu)
         []
  in
  funcs_including_calls |> List.iter ALlvm.delete_function;

  (* delete functions which return constant *)
  let funcs_ret_const_or_void =
    ALlvm.fold_left_functions
      (fun acc f ->
        let res =
          ALlvm.fold_left_all_instr
            (fun res instr ->
              if res then res
              else if ALlvm.instr_opcode instr = Ret then
                match ALlvm.classify_value (ALlvm.operand instr 0) with
                | ALlvm.ValueKind.ConstantInt | ConstantPointerNull | ConstantFP
                | NullValue | Function ->
                    (* if function returns constant then
                     * make a new function that returns an instruction,
                     * delete the old function. *)
                    subst_ret llctx instr wide
                | _ -> (
                    let ret_ty = ALlvm.operand instr 0 |> ALlvm.type_of in
                    match ALlvm.classify_type ret_ty with
                    (* if function is of void type then
                     * make a new function that returns an instruction,
                     * delete the old function. *)
                    | ALlvm.TypeKind.Void -> subst_ret llctx instr wide
                    | _ -> false)
              else false)
            false f
        in
        if res then f :: acc else acc)
      [] llm_clone
  in

  (* deletes subject functions after [subst_ret] *)
  List.rev funcs_ret_const_or_void |> List.iter ALlvm.delete_function;

  try
    if ALlvm.verify_module llm_clone then (
      let _ = ALlvm.choose_function llm_clone in
      ALlvm.reset_fun_names llm_clone;
      ALlvm.iter_functions ALlvm.reset_var_names llm_clone;
      Some llm_clone)
    else if wide then clean_llm llctx false llm
    else None
  with _ -> if wide then clean_llm llctx false llm else None
