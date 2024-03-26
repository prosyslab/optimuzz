open Util

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
      if ALlvm.ChangeRetVal.check_target i then (
        let new_ret_ty = ALlvm.type_of i in
        let f_new =
          ALlvm.define_function ""
            (ALlvm.function_type new_ret_ty param_tys)
            (ALlvm.global_parent f_old)
        in

        (* TODO: Check this reset names *)
        (* Copy names of the parameters (other than the extra parameters)
           to parameters of the newly created function, position-wise. *)
        (* ALlvm.params f_new
           |> Array.iteri (fun i param_new ->
                  if i >= Array.length params_old then ()
                  else
                    param_new
                    |> ALlvm.set_value_name (ALlvm.value_name params_old.(i))); *)
        (* copy function with new return value (target).*)
        ALlvm.ChangeRetVal.copy_blocks llctx f_old f_new;
        ALlvm.ChangeRetVal.migrate llctx f_old f_new i;

        true)
      else redef_fn llctx f_old wide i
  | None -> true

(* this function add the type-changed function in the module *)
let subst_ret llctx instr wide =
  let f_old = ALlvm.get_function instr in
  if ALlvm.ChangeRetVal.check_function f_old then
    redef_fn llctx f_old wide instr
  else true

let rec clean_llm llctx wide llm =
  (* make llm clone*)
  let llm_clone = Llvm_transform_utils.clone_module llm in

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
  List.iter
    (fun f -> ALlvm.delete_function f)
    (List.rev funcs_ret_const_or_void);

  try
    if ALlvm.verify_module llm_clone then (
      let _ = ALlvm.choose_function llm_clone in
      ALlvm.iter_functions ALlvm.reset_var_names llm_clone;
      Some llm_clone)
    else if wide then clean_llm llctx false llm
    else None
  with _ -> if wide then clean_llm llctx false llm else None
