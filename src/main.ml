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
