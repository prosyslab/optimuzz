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

  let join x y =
    let concat_cov a b =
      List.filter
        (fun compare -> List.for_all (fun origin -> origin <> compare) a)
        b
      @ a
    in
    if x = [] then y else List.mapi (fun i a -> concat_cov a (List.nth y i)) x
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

let interesting _cov1 _cov2 =
  let check_cov olist clist =
    List.exists
      (fun compare -> List.for_all (fun origin -> origin <> compare) olist)
      clist
  in
  if _cov1 = [] then true
  else List.exists2 (fun origin compare -> check_cov origin compare) _cov1 _cov2

let count = ref 0

let get_coverage file =
  ignore
    (Sys.command
       "find ./llvm-project/build/lib/Transforms -type f -name '*.gcda' | \
        xargs rm");

  let llc_pid =
    Unix.create_process !Config.bin
      [| !Config.bin; "-O2"; "-S"; file |]
      Unix.stdin Unix.stdout Unix.stderr
  in
  Unix.waitpid [] llc_pid |> ignore;

  let rec create_gcov list =
    match list with
    | [] -> None
    | h :: t ->
        let llvm_pid =
          Unix.create_process "llvm-cov"
            [| "llvm-cov"; "gcov"; h |]
            Unix.stdin Unix.stdout Unix.stderr
        in
        Unix.waitpid [] llvm_pid |> ignore;
        create_gcov t
  in
  ignore (create_gcov !Config.gcda_list);
  let try_read fp = try Some (input_line fp) with End_of_file -> None in
  let rec loop acc fp =
    match try_read fp with
    | Some s ->
        let list = s |> String.split_on_char ':' in
        let count =
          try list |> List.hd |> String.trim |> int_of_string
          with Failure "int_of_string" -> -1
        in
        if count > 0 then
          loop ((List.nth list 1 |> String.trim |> int_of_string) :: acc) fp
        else loop acc fp
    | None ->
        close_in fp;
        List.rev acc
  in
  let rec read_gcov list cov =
    match list with
    | h :: t ->
        let fp = open_in h in
        read_gcov t (loop [] fp :: cov)
    | [] -> List.rev cov
  in

  let coverage = read_gcov !Config.gcov_list [] in

  coverage

let run llm =
  count := !count + 1;
  let output_name =
    Filename.concat !Config.out_dir (string_of_int !count ^ ".ll")
  in
  Llvm.print_module output_name llm;
  (if not !Config.no_tv then
   let pid =
     Unix.create_process !Config.alive2_bin
       [| !Config.alive2_bin; output_name |]
       Unix.stdin Unix.stdout Unix.stderr
   in
   Unix.waitpid [] pid |> ignore);
  let result = true in
  let coverage = get_coverage output_name in
  (result, coverage)

let rec repeat_mutate seed num =
  if num = 0 then seed else repeat_mutate (Mutation.run llctx seed) (num - 1)

let rec fuzz pool coverage crashes =
  let seed, pool = SeedPool.pop pool in
  let mutant = repeat_mutate seed 5 in
  let result, coverage' = run mutant in
  let pool =
    if interesting coverage coverage' then SeedPool.push mutant pool else pool
  in
  let coverage = Coverage.join coverage coverage' in
  let crashes = if result then mutant :: crashes else crashes in
  if SeedPool.cardinal pool = 0 then coverage else fuzz pool coverage crashes

let rec acc_cov list acc =
  match list with [] -> acc | h :: t -> acc_cov t (acc + List.length h)

let main () =
  initialize ();
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#seeds: %d\n" (SeedPool.cardinal seed_pool);
  let coverage = fuzz seed_pool [] [] in
  ignore (Sys.command "rm *.gcov");
  F.printf "total coverage %d lines\n" (acc_cov coverage 0)

let _ = main ()
