module F = Format

let _ = Random.init 1234
let llctx = Llvm.create_context ()

module M = Mutation

module SeedPool = struct
  type t = Llvm.llmodule Queue.t

  let push s pool =
    Queue.push s pool;
    pool

  let pop pool = (Queue.pop pool, pool)
  let cardinal = Queue.length

  let of_dir dir =
    assert (Sys.file_exists dir && Sys.is_directory dir);
    Sys.readdir dir |> Array.to_list
    |> List.filter (fun file -> Filename.extension file = ".ll")
    |> List.fold_left
         (fun queue file ->
           Filename.concat dir file |> Llvm.MemoryBuffer.of_file
           |> Llvm_irreader.parse_ir llctx
           |> Fun.flip push queue)
         (Queue.create ())
end

module Coverage = struct
  type t = int list

  let join x y = x @ y
end

let initialize () =
  Random.self_init ();
  (try Sys.mkdir "llfuzz-out" 0o755 with _ -> ());
  let usage = "Usage: llfuzz [seed_dir]" in
  Arg.parse Config.opts
    (fun x ->
      Config.project_home :=
        Sys.argv.(0) |> Unix.realpath |> Filename.dirname |> Filename.dirname
        |> Filename.dirname |> Filename.dirname;
      Config.alive2_bin :=
        Filename.concat !Config.project_home "alive2/build/alive-tv";
      Config.seed_dir := x)
    usage

(** [modify_value v l] slightly modifies value [v]
    or returns a random element of [l]. *)
let modify_value v l =
  let inttype = Llvm.i32_type llctx in
  let c =
    match Llvm.int64_of_const v with
    | Some con -> (
        match Random.int 3 with
        | 0 -> Int64.to_int con * 2
        | 1 -> Int64.to_int con * -1
        | _ -> Int64.to_int con + 1)
    | None -> Random.int 200 - 100
  in
  match l with
  | [] -> Llvm.const_int inttype c
  | _ -> Utils.list_random [ Utils.list_random l; Llvm.const_int inttype c ]

(** [create_random_instr instr] create
    a random binary integer arithmetic operation [instr]
    with a list of arguments declared before instr.
    Returns the new instruction. *)
let create_random_instr instr =
  let list = Utils.get_assignments_before instr in
  let opcode = Utils.random_opcode_except None in
  M.create_arith_instr llctx instr opcode
    (modify_value (Llvm.operand instr 0) list)
    (modify_value (Llvm.operand instr 1) list)

(** [substitute_operand instr] substitutes
    operand of instruction with another integer value
    Return origin instr[instr]. *)
let substitute_operand instr =
  let list = Utils.get_assignments_before instr in
  (if Utils.OpcodeClass.classify (Llvm.instr_opcode instr) = ARITH && list <> []
  then
   (* If there is no previously declared argument, instruction is constant*)
   let i = Random.int 2 in
   Llvm.set_operand instr i (modify_value (Llvm.operand instr i) list));
  instr

let mutate llm =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  let f =
    (* assume the sole function *)
    match Llvm.function_begin llm_clone with
    | Before f -> f
    | At_end _ -> failwith "No function defined"
  in
  let arith_instr_list =
    Utils.fold_left_all_instr
      (fun a i ->
        if
          i |> Llvm.instr_opcode |> Utils.OpcodeClass.classify
          = Utils.OpcodeClass.ARITH
        then i :: a
        else a)
      [] f
  in
  let i =
    match arith_instr_list with
    | [] -> Utils.get_return_instr f
    | _ -> Utils.list_random arith_instr_list
  in
  let mutate_fun =
    Utils.list_random
      [
        (fun i -> ignore (substitute_operand i));
        (fun i ->
          i |> Llvm.instr_opcode |> Option.some |> Utils.random_opcode_except
          |> M.substitute_arith_instr llctx i
          |> ignore);
        (fun i -> ignore (create_random_instr i));
        (fun i -> ignore (M.build_alloca_instr llctx i));
        (fun i -> ignore (M.build_load_instr llctx i));
        (fun i -> ignore (M.build_store_instr llctx i));
      ]
  in
  mutate_fun i;
  llm_clone

let interesting _cov1 _cov2 = true
let count = ref 0

let run llm =
  count := !count + 1;
  let output_name =
    Filename.concat !Config.out_dir (string_of_int !count ^ ".ll")
  in
  Llvm.print_module output_name llm;
  let pid =
    Unix.create_process !Config.alive2_bin
      [| !Config.alive2_bin; output_name |]
      Unix.stdin Unix.stdout Unix.stderr
  in
  Unix.waitpid [] pid |> ignore;

  let result = true in
  let coverage = [] in
  (result, coverage)

let rec fuzz pool coverage crashes =
  let seed, pool = SeedPool.pop pool in
  let mutant = mutate seed in
  let result, coverage' = run mutant in
  let pool =
    if interesting coverage coverage' then SeedPool.push mutant pool else pool
  in
  let coverage = Coverage.join coverage coverage' in
  let crashes = if result then mutant :: crashes else crashes in
  fuzz pool coverage crashes

let main () =
  initialize ();
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#seeds: %d\n" (SeedPool.cardinal seed_pool);
  fuzz seed_pool [] []

let _ = main ()
