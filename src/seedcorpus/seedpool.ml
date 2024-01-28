open Util
open Oracle

module SeedTuple = struct
  type t = Llvm.llmodule * int

  let compare (llm1, distance1) (llm2, distance2) =
    if distance1 == distance2 then
      let llm1_size = llm1 |> ALlvm.string_of_llmodule |> String.length in
      let llm2_size = llm2 |> ALlvm.string_of_llmodule |> String.length in
      Int.compare llm1_size llm2_size
    else Int.compare distance1 distance2
end

module SeedSet = struct
  include Set.Make (SeedTuple)

  let add seedtuple set =
    if cardinal set < !Config.max_initial_seed then add seedtuple set
    else
      let filtered =
        filter
          (fun tuple ->
            if SeedTuple.compare tuple seedtuple <= 0 then true else false)
          set
      in
      if cardinal filtered < !Config.max_initial_seed then
        add seedtuple filtered
      else filtered
end

type elt = Llvm.llmodule * bool * int
type t = elt Queue.t

let push s pool =
  Queue.push s pool;
  pool

let pop pool = (Queue.pop pool, pool)
let cardinal = Queue.length

let check_exist_ret f =
  ALlvm.fold_left_all_instr
    (fun res instr ->
      if res then res
      else match ALlvm.instr_opcode instr with Ret -> true | _ -> false)
    false f

let collect_instruction_types f =
  ALlvm.fold_left_all_instr
    (fun types instr_old ->
      let ty = ALlvm.type_of instr_old in
      match ALlvm.classify_type ty with Void -> types | _ -> ty :: types)
    [] f

(** *)
let subst_ret llctx instr wide =
  let f_old = ALlvm.get_function instr in
  (* Set var names *)
  ALlvm.set_var_names f_old;

  let types = collect_instruction_types f_old in
  let extra_param =
    match types with
    | [] -> [| ALlvm.i32_type llctx; ALlvm.i32_type llctx |]
    | _ ->
        let ty = AUtil.choose_random types in
        [| ty; ty |]
  in

  let params_old = ALlvm.params f_old in
  let param_tys =
    Array.append (Array.map ALlvm.type_of params_old) extra_param
  in

  let target = ALlvm.get_instr_before ~wide instr in
  match target with
  | Some i ->
      let new_ret_ty = ALlvm.type_of i in
      let f_new =
        ALlvm.define_function ""
          (ALlvm.function_type new_ret_ty param_tys)
          (ALlvm.global_parent f_old)
      in
      (* Copy names of the parameters (other than the extra parameters)
         to parameters of the newly created function, position-wise. *)
      ALlvm.params f_new
      |> Array.iteri (fun i param_new ->
             if i >= Array.length params_old then ()
             else
               param_new
               |> ALlvm.set_value_name (ALlvm.value_name params_old.(i)));
      ALlvm.copy_function_with_new_retval llctx f_old f_new new_ret_ty;
      true
  | None -> true

let rec clean_llm llctx wide llm =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  let deleted_functions =
    ALlvm.fold_left_functions
      (fun acc f ->
        if not (check_exist_ret f) then f :: acc
        else
          let res =
            ALlvm.fold_left_all_instr
              (fun res instr ->
                if res then res
                else
                  match ALlvm.instr_opcode instr with
                  | Call -> if ALlvm.is_llvm_intrinsic instr then res else true
                  | Ret -> (
                      if res then res
                      else
                        match ALlvm.classify_value (ALlvm.operand instr 0) with
                        | ALlvm.ValueKind.ConstantInt | ConstantPointerNull
                        | ConstantFP | NullValue | Function ->
                            subst_ret llctx instr wide
                        | _ -> (
                            let ret_ty =
                              ALlvm.operand instr 0 |> ALlvm.type_of
                            in
                            match ALlvm.classify_type ret_ty with
                            | ALlvm.TypeKind.Void -> subst_ret llctx instr wide
                            | _ -> false))
                  | _ -> false)
              false f
          in
          if res then f :: acc else acc)
      [] llm_clone
  in
  List.iter (fun f -> ALlvm.delete_function f) (List.rev deleted_functions);
  try
    if ALlvm.verify_module llm_clone then
      let _ = ALlvm.choose_function llm_clone in
      Some llm_clone
    else if wide then clean_llm llctx false llm
    else None
  with _ -> if wide then clean_llm llctx false llm else None

(** make seedpool from Config.seed_dir. this queue contains llmodule, covered, distance *)
let make llctx =
  let dir = !Config.seed_dir in
  assert (Sys.file_exists dir && Sys.is_directory dir);
  let seedpool, seedset =
    Sys.readdir dir |> Array.to_list
    |> List.filter (fun file -> Filename.extension file = ".ll")
    |> List.fold_left
         (fun (queue, seedset) file ->
           let path = Filename.concat dir file in
           match
             Oracle.Optimizer.run
               ~passes:
                 [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ]
               path
           with
           | CRASH | INVALID ->
               AUtil.name_opted_ver path |> AUtil.clean;
               (queue, seedset)
           | VALID -> (
               AUtil.name_opted_ver path |> AUtil.clean;
               let llm =
                 path |> ALlvm.MemoryBuffer.of_file
                 |> Llvm_irreader.parse_ir llctx
                 |> clean_llm llctx true
               in
               match llm with
               | Some llm -> (
                   Coverage.Measurer.clean ();
                   match
                     Oracle.Optimizer.run_for_llm ~passes:[ "instcombine" ] llm
                   with
                   | CRASH | INVALID -> (queue, seedset)
                   | VALID -> (
                       let distance =
                         Coverage.Measurer.run ()
                         |> Coverage.Domain.DistanceSet.min_elt
                       in
                       if distance == 0 then
                         (push (llm, true, distance) queue, seedset)
                       else
                         try (queue, SeedSet.add (llm, distance) seedset)
                         with _ -> (queue, seedset)))
               | None -> (queue, seedset)))
         (Queue.create (), SeedSet.empty)
  in
  if Queue.is_empty seedpool then
    SeedSet.fold
      (fun (llm, distance) seedpool -> push (llm, false, distance) seedpool)
      seedset seedpool
  else seedpool
