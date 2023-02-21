module F = Format

let _ = Random.init 1234
let llctx = Llvm.create_context ()
let count = ref 0
let time = ref 0.0
let start_time = ref 0.0

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
  module FNameMap = Map.Make (String)
  module LineSet = Set.Make (Int)

  type t = LineSet.t FNameMap.t

  let empty = FNameMap.empty
  let add = FNameMap.add
  let empty_set = LineSet.empty
  let add_set = LineSet.add

  (** [join x y] adds all coverage in [y] into [x]. *)
  let join x y =
    FNameMap.fold
      (fun k d_y accu ->
        add k
          (match FNameMap.find_opt k accu with
          | Some d_x -> LineSet.union d_x d_y
          | None -> d_y)
          accu)
      y x

  (** [is_sub x y] returns whether [y] is a total subset of [x]. *)
  let is_sub x y =
    FNameMap.for_all
      (fun k d_y ->
        match FNameMap.find_opt k x with
        | Some d_x -> LineSet.subset d_y d_x
        | None -> false)
      y

  (** [total_cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let total_cardinal x =
    FNameMap.fold (fun _ d accu -> accu + LineSet.cardinal d) x 0

  let print x =
    print_endline "[";
    FNameMap.iter
      (fun k d ->
        print_string k;
        print_string ": {";
        LineSet.iter
          (fun elem ->
            print_int elem;
            print_string " ")
          d;
        print_endline "}")
      x;
    print_endline "]"
end

let initialize () =
  Random.self_init ();
  time := Unix.time ();
  start_time := Unix.time ();
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

let get_coverage () =
  List.iter
    (fun elem ->
      let llvm_pid =
        Unix.create_process "llvm-cov"
          [| "llvm-cov"; "gcov"; elem |]
          Unix.stdin Unix.stdout Unix.stderr
      in
      Unix.waitpid [] llvm_pid |> ignore)
    Config.gcda_list;
  let rec aux fp accu =
    try
      (* each line is the form of [COVERED_TIMES:LINE_NUM:CODE] *)
      let chunks = String.split_on_char ':' (input_line fp) in
      if
        (try chunks |> List.hd |> String.trim |> int_of_string
         with Failure _ -> -1)
        > 0
      then
        aux fp
          (Coverage.add_set
             (List.nth chunks 1 |> String.trim |> int_of_string)
             accu)
      else aux fp accu
    with End_of_file ->
      close_in fp;
      accu
  in
  List.fold_left
    (fun accu elem ->
      Coverage.add elem (aux (open_in elem) Coverage.empty_set) accu)
    Coverage.empty Config.gcov_list

let check_result log =
  let file = open_in log in
  let try_read fp = try Some (input_line fp) with End_of_file -> None in
  let rec loop acc fp =
    match try_read fp with
    | Some s -> loop (s :: acc) fp
    | None ->
        close_in fp;
        List.rev acc
  in
  try
    (List.find
       (fun l ->
         let l = l |> String.split_on_char ' ' in
         if List.length l > 3 then List.nth l 3 = "incorrect" else false)
       (loop [] file)
    |> String.split_on_char ' ' |> List.nth)
      2
    = "1"
  with Failure _ -> false

let run llm =
  ignore
    (Sys.command
       ("find " ^ !Config.project_home
      ^ "./llvm-project/build/lib/Transforms -type f -name '*.gcda' | xargs rm"
       ));
  count := !count + 1;
  let output_name =
    Filename.concat !Config.out_dir (string_of_int !count ^ ".ll")
  in
  Llvm.print_module output_name llm;
  (if not !Config.no_tv then
   let pid =
     Unix.create_process !Config.alive2_bin
       [| !Config.alive2_bin; output_name |]
       Unix.stdin
       (Unix.openfile !Config.alive2_log [ O_CREAT; O_WRONLY ] 0o640)
       Unix.stderr
   in
   Unix.waitpid [] pid |> ignore);
  let result = check_result !Config.alive2_log in
  let coverage = get_coverage () in
  (result, coverage)

let rec fuzz pool coverage crashes =
  let seed, pool_popped = SeedPool.pop pool in
  (* update pool, coverage, and crashes
     by generating n mutants from single seed *)
  let pool_new, coverage_new, crashes_new =
    Utils.repeat_fun
      (fun (p, co, cr) ->
        (* a mutant is mutated n times from the seed *)
        let mutant =
          Utils.repeat_fun
            (fun llm -> Mutation.run llctx llm)
            seed !Config.mutate_times
        in
        let result, co' = run mutant in
        let p_step =
          if Coverage.is_sub co co' then p else SeedPool.push mutant p
        in
        let co_step = Coverage.join co co' in
        let cr_step = if result then mutant :: cr else cr in
        (p_step, co_step, cr_step))
      (pool_popped, coverage, crashes)
      !Config.fuzzing_times
  in
  (* repeat until the seed pool exhausts *)
  if SeedPool.cardinal pool_new = 0 then (coverage_new, crashes_new)
  else fuzz pool_new coverage_new crashes_new

let main () =
  initialize ();
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#seeds: %d\n" (SeedPool.cardinal seed_pool);
  let coverage, crashes = fuzz seed_pool Coverage.empty [] in
  ignore (Sys.command "rm *.gcov");
  Unix.unlink !Config.alive2_log;
  Utils.note_module_list crashes !Config.crash_log;
  F.printf "total coverage: %d lines\n" (Coverage.total_cardinal coverage)

let _ = main ()
