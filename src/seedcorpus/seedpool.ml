open Util
module CD = Coverage.Domain
module L = Logger

type seed_t = {
  priority : int;
  llm : Llvm.llmodule;
  covers : bool;
  score : float;
}

type t = seed_t AUtil.PrioQueue.queue

let pp_seed fmt seed =
  Format.fprintf fmt "score: %.3f, covers: %b" seed.score seed.covers

let name_seed ?(parent : seed_t option) (seed : seed_t) =
  let self_hash = ALlvm.hash_llm seed.llm in
  match parent with
  | None ->
      Format.sprintf "id:%010d,score:%f,covers:%b.ll" self_hash seed.score
        seed.covers
  | Some src ->
      let parent_hash = ALlvm.hash_llm src.llm in
      Format.sprintf "id:%010d,src:%010d,score:%f,covers:%b.ll" self_hash
        parent_hash seed.score seed.covers

let get_prio covers score =
  if covers then 0 else score |> Float.mul 10.0 |> Float.to_int

let push s pool = AUtil.PrioQueue.insert pool s.priority s
let pop pool = AUtil.PrioQueue.extract pool
let cardinal = AUtil.PrioQueue.length
let push_list l (p : t) = List.fold_left (fun pool seed -> push seed pool) p l
let iter = AUtil.PrioQueue.iter

let check_exist_ret func =
  let is_ret instr = ALlvm.instr_opcode instr = Ret in
  ALlvm.any_all_instr is_ret func

let collect_instruction_types func =
  func
  |> ALlvm.filter_all_instr (fun instr ->
         ALlvm.type_of instr |> ALlvm.classify_type <> Void)
  |> List.fold_left (fun accu instr -> ALlvm.type_of instr :: accu) []

let subst_ret llctx instr wide =
  let f_old = ALlvm.get_function instr in
  (* Set var names *)
  ALlvm.reset_var_names f_old;

  let types = collect_instruction_types f_old in
  (* add dummpy parameters *)
  let extra_param =
    match types with
    | [] -> [| ALlvm.i32_type llctx; ALlvm.i32_type llctx |]
    | _ ->
        let ty = AUtil.choose_random types in
        [| ty; ty |]
  in

  (* make param map to copy function. *)
  let params_old = ALlvm.params f_old in
  let param_tys =
    Array.append (Array.map ALlvm.type_of params_old) extra_param
  in

  (* target: new instruction will returned.*)
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
      (* copy function with new return value (target).*)
      ALlvm.ChangeRetVal.copy_function_with_new_retval llctx f_old f_new
        new_ret_ty;
      true
  | None -> true

(* If the functions return a constant, copy the functions to return another instruction and delete the original function. *)
let rec clean_llm llctx wide llm =
  (* make llm clone*)
  let llm_clone = Llvm_transform_utils.clone_module llm in
  (* search functions return constant*)
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
                            (* if function returns constant then substitute return instruction. *)
                            subst_ret llctx instr wide
                        | _ -> (
                            let ret_ty =
                              ALlvm.operand instr 0 |> ALlvm.type_of
                            in
                            match ALlvm.classify_type ret_ty with
                            (* if function is void type then substitute return instruction. *)
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
let make llctx llset =
  let dir = !Config.seed_dir in
  let target_path = CD.Path.parse !Config.cov_directed |> Option.get in
  assert (Sys.file_exists dir && Sys.is_directory dir);

  let seed_files =
    Sys.readdir dir
    |> Array.to_list
    |> List.filter (fun file -> Filename.extension file = ".ll")
  in

  let can_optimize file =
    let path = Filename.concat dir file in
    match Oracle.Optimizer.run ~passes:[ "instcombine" ] path with
    | Ok _ -> true
    | _ -> false
  in

  let score_func =
    match !Config.metric with
    | "avg" -> CD.Coverage.avg_score
    | "min" -> CD.Coverage.min_score
    | _ -> failwith "invalid metric"
  in

  (* pool_covers contains seeds which cover the target *)
  (* other_seeds contains seeds which do not *)
  let pool_covers, other_seeds =
    seed_files
    |> List.fold_left
         (fun (pool_first, other_seeds) file ->
           let path = Filename.concat dir file in
           if can_optimize file |> not then (pool_first, other_seeds)
           else
             let llm =
               ALlvm.MemoryBuffer.of_file path
               |> Llvm_irreader.parse_ir llctx
               |> (fun llm ->
                    ALlvm.clean_module_data llm;
                    llm)
               |> clean_llm llctx true
             in
             match llm with
             | None -> (pool_first, other_seeds)
             | Some llm -> (
                 let filename =
                   Format.sprintf "id:%010d.ll" (ALlvm.hash_llm llm)
                 in
                 ALlvm.save_ll !Config.out_dir filename llm;
                 let opt_res =
                   Filename.concat !Config.out_dir filename
                   |> Oracle.Optimizer.run ~passes:[ "instcombine" ]
                 in
                 AUtil.clean filename;

                 match opt_res with
                 | Error Crash | Error No_cov -> (pool_first, other_seeds)
                 | Ok cov ->
                     let covers = CD.Coverage.cover_target target_path cov in
                     let score =
                       match score_func target_path cov with
                       | None -> !Config.max_distance |> float_of_int
                       | Some x -> x
                     in
                     let seed =
                       { priority = get_prio covers score; llm; covers; score }
                     in
                     L.info "seed: %s, %a" file pp_seed seed;
                     if covers then (seed :: pool_first, other_seeds)
                     else (pool_first, seed :: other_seeds)))
         ([], [])
  in

  (* if we have covering seeds, we use covering seeds only. *)
  if pool_covers = [] then (
    L.info "No covering seeds found. Using closest seeds.";
    (* pool_closest contains seeds which are closest to the target *)
    let pool_closest =
      other_seeds
      |> List.sort_uniq (fun a b ->
             compare (ALlvm.hash_llm a.llm) (ALlvm.hash_llm b.llm))
      |> List.sort (fun a b -> compare a.score b.score)
    in
    let new_set =
      pool_covers
      |> List.fold_left (fun s seed -> ALlvm.LLModuleSet.add seed.llm s) llset
    in

    let _cnt, pool_closest =
      pool_closest
      |> List.fold_left
           (fun (cnt, pool) seed ->
             if cnt >= !Config.max_initial_seed then (cnt, pool)
             else (cnt + 1, push seed pool))
           (0, AUtil.PrioQueue.empty)
    in

    pool_closest
    |> iter (fun seed ->
           let filename = name_seed seed in
           Format.eprintf "%s@." filename;
           ALlvm.save_ll !Config.corpus_dir filename seed.llm);

    (new_set, pool_closest))
  else (
    (* if we have covering seeds, we use covering seeds only. *)
    L.info "Covering seeds found. Using them only.";
    let pool_covers =
      pool_covers
      |> List.sort_uniq (fun a b ->
             compare (ALlvm.hash_llm a.llm) (ALlvm.hash_llm b.llm))
    in
    let new_set =
      pool_covers
      |> List.fold_left (fun s seed -> ALlvm.LLModuleSet.add seed.llm s) llset
    in
    pool_covers
    |> List.iter (fun seed ->
           let filename = name_seed seed in
           Format.eprintf "%s@." filename;
           ALlvm.save_ll !Config.corpus_dir filename seed.llm);
    (new_set, push_list pool_covers AUtil.PrioQueue.empty))
