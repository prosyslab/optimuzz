open Util
module L = Logger
module D = Domain
module Trace = Coverage.BlockTrace
module Opt = Oracle.Optimizer

module type QUEUE = sig
  type elt
  type t

  val empty : t

  val push : elt -> t -> t
  (** push a seed to the queue -- not the first time *)

  val pop : t -> elt * t
  val length : t -> int
  val iter : (elt -> unit) -> t -> unit
end

module CfgSeed = struct
  module Distance = Coverage.CfgDistance

  type t = {
    llm : Llvm.llmodule;
    score : Distance.t;
    covers : bool;
    edge_cov : Coverage.EdgeCoverage.t;
    importants : string;
  }

  let make llm trace importants node_tbl distmap =
    let score = Distance.distance_score trace node_tbl distmap in
    let covers = Distance.get_cover trace node_tbl distmap in
    let edge_cov = Coverage.EdgeCoverage.of_trace trace in
    { llm; score; covers; edge_cov; importants }

  let llmodule seed = seed.llm
  let covers seed = seed.covers
  let score seed = seed.score
  let edge_cov seed = seed.edge_cov

  let get_energy seed =
    if !Config.score = Config.FuzzingMode.Constant then 4
    else
      let int_score = Float.to_int seed.score in
      if seed.covers then 12 else if int_score >= 10 then 3 else 12 - int_score

  let name ?parent seed =
    let hash = ALlvm.hash_llm seed.llm in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d,score:%f,covers:%b.ll"
          (AUtil.get_current_time ())
          hash seed.score seed.covers
    | Some parent_hash ->
        Format.asprintf "date:%s,id:%010d,src:%010d,score:%f,covers:%b.ll"
          (AUtil.get_current_time ())
          hash parent_hash seed.score seed.covers

  let pp fmt seed =
    Format.fprintf fmt "score: %f, covers: %b,@.%s" seed.score seed.covers
      (ALlvm.string_of_llmodule seed.llm)
end

module Seed = CfgSeed
include Queue

let has_substr substr llv =
  try
    ignore
      (Str.search_forward (Str.regexp_string substr)
         (ALlvm.string_of_llvalue llv)
         0);
    true
  with Not_found -> false

let check_value_type_for_mutation llv =
  let ty = ALlvm.type_of llv in
  if String.starts_with ~prefix:"target" (ALlvm.string_of_lltype ty) then false
  else
    match ALlvm.classify_type ty with
    | Void | Half | Float | Double | Fp128 | Label | Integer | Function | Array
    | Metadata ->
        true
    | Vector -> ty |> ALlvm.element_type |> ALlvm.classify_type = Integer
    | Pointer ->
        if has_substr "inttoptr" llv then false
        else if has_substr "no_cfi" llv then false
        else ALlvm.address_space ty = 0 && not (ALlvm.is_null llv)
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

let check_llv_for_mutation llv =
  match ALlvm.classify_value llv with
  | Instruction opc ->
      opc |> check_opc_for_mutation |> check_opd_for_mutation 0 llv
  | _ -> check_value_type_for_mutation llv

let check_func_for_mutation f =
  ALlvm.for_all_params check_llv_for_mutation f
  && ALlvm.for_all_instr check_llv_for_mutation f

let check_llm_for_mutation llm =
  ALlvm.for_all_globals check_llv_for_mutation llm
  && ALlvm.for_all_functions check_func_for_mutation llm

let check_exist_ret f =
  ALlvm.any_all_instr (fun instr -> ALlvm.instr_opcode instr = Ret) f

let rec redef_fn llctx f_old wide instr =
  let extra_param = [| ALlvm.i32_type llctx; ALlvm.pointer_type llctx |] in
  let fmodule = ALlvm.global_parent f_old in
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
        let new_fty = ALlvm.function_type new_ret_ty param_tys in
        let f_new = ALlvm.define_function "" new_fty fmodule in

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

let is_in_slice node_tbl distmap line =
  match !Config.coverage with
  | Config.FuzzingMode.Sliced_cfg ->
      int_of_string line
      |> Coverage.node_of_addr node_tbl distmap
      |> Option.is_some
  | _ -> true

let can_optimize seedfile node_tbl distmap =
  match
    Opt.run ~passes:!Config.optimizer_passes ~mtriple:!Config.mtriple seedfile
  with
  | Error Non_zero_exit | Error Hang | Assert _ ->
      L.debug "%s cannot be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      None
  | Error File_not_found ->
      L.debug "coverage of %s is not generated" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      if !Config.coverage = Config.FuzzingMode.All_edges then Some (seedfile, [])
      else None
  | Ok lines ->
      L.debug "%s can be optimized" seedfile;
      AUtil.name_opted_ver seedfile |> AUtil.clean;
      let lines = lines |> List.filter (is_in_slice node_tbl distmap) in
      Some (seedfile, lines)

let push (seed : Seed.t) pool =
  push seed pool;
  pool

let pop pool =
  let seed = pop pool in
  (seed, pool)

let save ?(parent : int option) (seed : Seed.t) =
  let llm = seed.llm in
  let seed_name =
    match parent with
    | None -> Seed.name seed
    | Some parent -> Seed.name ~parent seed
  in
  let mutated_filename =
    Filename.concat !Config.corpus_dir
      (Filename.chop_suffix seed_name ".ll" ^ ".mutated")
  in
  Out_channel.with_open_text mutated_filename (fun line ->
      Printf.fprintf line "%s" seed.importants);
  ALlvm.save_ll !Config.corpus_dir seed_name llm |> ignore

let is_optimuzz_base () =
  (* Optimuzz_Base *)
  !Config.score = Config.FuzzingMode.Constant
  && !Config.coverage = Config.FuzzingMode.All_edges

let is_nondirected () = !Config.coverage = Config.FuzzingMode.All_edges

let log_seed seed =
  L.debug "evaluate seed: \n%s\n" (ALlvm.string_of_llmodule seed.Seed.llm);
  L.debug "score: %f" (Seed.score seed)

let classify_seeds node_tbl distmap raw_seeds =
  if is_nondirected () then
    List.fold_left
      (fun (cover_seeds, noncover_seeds) (_, llm, traces) ->
        let seed = Seed.make llm traces "" node_tbl distmap in
        log_seed seed;
        (cover_seeds, seed :: noncover_seeds))
      ([], []) raw_seeds
  else
    List.fold_left
      (fun (cover_seeds, noncover_seeds) (_, llm, traces) ->
        let seed = Seed.make llm traces "" node_tbl distmap in
        log_seed seed;
        if Seed.covers seed then (seed :: cover_seeds, noncover_seeds)
        else (cover_seeds, seed :: noncover_seeds))
      ([], []) raw_seeds

let hash_seed seed = ALlvm.hash_llm seed.Seed.llm
let compare_hash a b = compare (hash_seed a) (hash_seed b)
let compare_score a b = compare a.Seed.score b.Seed.score

let closest_seeds seeds =
  let unique_seeds = List.sort_uniq compare_hash seeds in
  let sorted_seeds =
    if !Config.score = Config.FuzzingMode.Constant then unique_seeds
    else
      unique_seeds
      |> List.sort (fun a b -> compare (Seed.score a) (Seed.score b))
  in
  let first_seeds =
    if !Config.coverage = Config.FuzzingMode.All_edges then sorted_seeds
    else List.take !Config.max_initial_seed sorted_seeds
  in
  first_seeds

let compute_init_cov seeds =
  let open Coverage in
  List.fold_left
    (fun accu seed -> EdgeCoverage.union accu seed.Seed.edge_cov)
    EdgeCoverage.empty seeds

let make_pool_and_cov seeds =
  let pool = create () in
  seeds |> List.to_seq |> add_seq pool;
  let init_cov = compute_init_cov seeds in
  (pool, init_cov)

let evaluate_seeds_and_construct_seedpool raw_seeds node_tbl distmap =
  let open Coverage in
  if is_optimuzz_base () then
    let _, seeds = classify_seeds node_tbl distmap raw_seeds in
    make_pool_and_cov seeds
  else
    let cover_seeds, noncover_seeds =
      classify_seeds node_tbl distmap raw_seeds
    in
    if cover_seeds = [] then (
      L.info "No covering seeds found. Using closest seeds.";
      let pool_closest = closest_seeds noncover_seeds in
      make_pool_and_cov pool_closest)
    else (
      L.info "Covering seeds found. Using them only.";
      let sorted_seeds = cover_seeds |> List.sort_uniq compare_score in
      make_pool_and_cov sorted_seeds)

let make llctx node_tbl (distmap : float Coverage.DistanceTable.t) =
  let open AUtil in
  let seed_dir = !Config.seed_dir in

  let add_dummy_params llm =
    let open ALlvm in
    let f_alls = fold_left_functions (fun accu f -> f :: accu) [] llm in
    let f_olds =
      List.fold_left
        (fun accu f_old ->
          let dummy_params = [| pointer_type llctx |] in
          let old_params = params f_old in
          let param_tys =
            Array.append (Array.map type_of old_params) dummy_params
          in
          let new_fnty = function_type (get_return_type f_old) param_tys in
          let name = value_name f_old in
          let f_new = clone_function_with_fnty f_old new_fnty in

          set_value_name name f_new;
          f_old :: accu)
        [] f_alls
    in
    f_olds
    |> List.rev
    |> List.iter (fun f_old ->
           replace_all_uses_with f_old (undef (pointer_type llctx));
           delete_function f_old);
    llm
  in

  let seed_count = ref 0 in

  let preprocess_seed seed =
    let* path, lines = can_optimize seed node_tbl distmap in
    L.debug "filter seed: %s " path;
    match ALlvm.read_ll llctx path with
    | Ok llm when check_llm_for_mutation llm ->
        let cov = lines |> List.map int_of_string in
        let llm = add_dummy_params llm in
        seed_count := !seed_count + 1;
        L.debug "seed count: %d" !seed_count;
        Some (path, llm, cov)
    | _ -> None
  in

  let seeds =
    let seed_files = Sys.readdir seed_dir in
    L.info "%d seeds found" (Array.length seed_files);

    Array.to_list seed_files
    |> List.map (Filename.concat seed_dir)
    |> List.filter_map preprocess_seed
  in

  evaluate_seeds_and_construct_seedpool seeds node_tbl distmap
