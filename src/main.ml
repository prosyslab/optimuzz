module F = Format

let llctx = Llvm.create_context ()

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

(** [substitute_instr opcode instr] substitutes
    a binary integer arithmetic operation [instr]
    into another operation (with opcode [opcode]).
    It does not use extra keywords such as nsw, nuw, exact, etc. *)
let substitute_instr instr opcode =
  (* Add, Sub, Mul, UDiv, SDiv, URem, SRem *)
  let open Llvm.Opcode in
  let build_op =
    match opcode with
    | Add -> Llvm.build_add
    | Sub -> Llvm.build_sub
    | Mul -> Llvm.build_mul
    | UDiv -> Llvm.build_udiv
    | SDiv -> Llvm.build_sdiv
    | URem -> Llvm.build_urem
    | SRem -> Llvm.build_srem
    | _ -> failwith "Unsupported"
  in
  let new_instr =
    build_op (Llvm.operand instr 0) (Llvm.operand instr 1) ""
      (Llvm.builder_before llctx instr)
  in
  Llvm.replace_all_uses_with instr new_instr;
  Llvm.delete_instruction instr

(** [split_block instr] splits the parent block of [instr] into two blocks
    and links them by unconditional branch.
    [instr] becomes the first instruction of the latter block.
    Returns the former block. *)
let split_block instr =
  let block = Llvm.instr_parent instr in
  let new_block = Llvm.insert_block llctx "" block in
  let builder = Llvm.builder_at_end llctx new_block in
  Llvm.position_before (Llvm.build_br block builder) builder;
  let rec aux () =
    match Llvm.instr_begin block with
    | Llvm.Before i when i = instr -> ()
    | Llvm.Before i ->
        let i_clone = Llvm.instr_clone i in
        Llvm.insert_into_builder i_clone "" builder;
        Llvm.replace_all_uses_with i i_clone;
        Llvm.delete_instruction i;
        aux ()
    | Llvm.At_end _ -> failwith "NEVER OCCUR"
  in
  aux ();
  new_block

(** [make_conditional instr] substitutes
    an unconditional branch instruction [instr]
    into trivial conditional branch instruction.
    Returns the conditional branch instruction. *)
let make_conditional instr =
  let block = Llvm.instr_parent instr in
  match instr |> Llvm.get_branch |> Option.get with
  | `Unconditional target_block ->
      let fbb = Llvm.append_block llctx "" (Llvm.block_parent block) in
      Llvm.move_block_after target_block fbb;
      ignore (Llvm.build_unreachable (Llvm.builder_at_end llctx fbb));
      Llvm.delete_instruction instr;
      Llvm.build_cond_br
        (Llvm.const_int (Llvm.integer_type llctx 1) 1)
        target_block fbb
        (Llvm.builder_at_end llctx block)
  | `Conditional _ -> failwith "Conditional branch already"

(** [make_unconditional instr] substitutes
    a conditional branch instruction [instr]
    into unconditional branch instruction targets for true-branch.
    Returns the unconditional branch instruction. *)
let make_unconditional instr =
  match instr |> Llvm.get_branch |> Option.get with
  | `Conditional (_, target_block, _) ->
      Llvm.delete_instruction instr;
      Llvm.build_br target_block
        (Llvm.builder_at_end llctx (Llvm.instr_parent instr))
  | `Unconditional _ -> failwith "Unconditional branch already"

(** [negate_condition instr] negates the condition of
    the conditional branch instruction [instr].
    Returns [instr] (with its condition negated). *)
let negate_condition instr =
  match instr |> Llvm.get_branch |> Option.get with
  | `Conditional (cond, _, _) ->
      Llvm.set_condition instr
        (Llvm.build_not cond "" (Llvm.builder_before llctx instr));
      instr
  | `Unconditional _ -> failwith "Unconditional branch"

let mutate llm =
  let llm_clone = Llvm_transform_utils.clone_module llm in
  let f =
    (* assume the sole function *)
    match Llvm.function_begin llm_clone with
    | Before f -> f
    | At_end _ -> failwith "No function defined"
  in
  llm_clone

let interesting cov1 cov2 = true
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
