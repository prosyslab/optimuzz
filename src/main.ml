open Domain
module F = Format

type opt_res_t = CRASH | INVALID | VALID

let llctx = Llvm.create_context ()
let count = ref 0

(* for logging *)
let alive2_log = "alive-tv.txt"
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp

(* helpers *)
let concat_home s = Filename.concat !Config.project_home s
let ll_of_count () = string_of_int !count ^ ".ll"
let now () = Unix.time () |> int_of_float

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

let initialize () =
  Arg.parse Config.opts
    (fun _ -> failwith "There must be no anonymous arguments.")
    "Usage: llfuzz [options]";

  (* these files are bound to llfuzz project *)
  Config.project_home :=
    Sys.argv.(0) |> Unix.realpath |> Filename.dirname |> Filename.dirname
    |> Filename.dirname |> Filename.dirname;
  Config.opt_bin := concat_home !Config.opt_bin;
  Config.alive2_bin := concat_home !Config.alive2_bin;
  Config.workspace := Unix.getcwd ();
  Config.gcov_dir := Filename.concat !Config.out_dir !Config.gcov_dir;
  (* these files are bound to (outer) workspace *)
  (try Sys.mkdir !Config.out_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.gcov_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.crash_dir 0o755 with _ -> ());
  Config.init_whitelist ();
  Config.init_gcda_list ();
  Config.init_gcov_list ();
  Random.init !Config.random_seed

let run_gcov () =
  Unix.chdir !Config.gcov_dir;
  let devnull = Unix.openfile "/dev/null" [ Unix.O_WRONLY ] 0o644 in
  List.iter
    (fun elem ->
      let llvm_pid =
        Unix.create_process "llvm-cov"
          [| "llvm-cov"; "gcov"; "-b"; "-c"; elem |]
          Unix.stdin devnull devnull
      in
      Unix.waitpid [] llvm_pid |> ignore)
    !Config.gcda_list;
  Unix.chdir !Config.workspace

let get_coverage () =
  run_gcov ();
  let rec aux fp accu =
    match input_line fp with
    | line ->
        (* each line is the form of [COVERED_TIMES:LINE_NUM:CODE] *)
        let chunks = String.split_on_char ':' line in
        if
          (try chunks |> List.hd |> String.trim |> int_of_string
           with Failure _ -> -1)
          > 0
        then
          aux fp
            (LineSet.add
               (List.nth chunks 1 |> String.trim |> int_of_string)
               accu)
        else aux fp accu
    | exception End_of_file ->
        close_in fp;
        accu
  in
  List.fold_left
    (fun accu elem ->
      LineCoverage.add elem (aux (open_in elem) LineSet.empty) accu)
    LineCoverage.empty !Config.gcov_list

let run_alive2 filename =
  (* run alive2 *)
  let pid =
    Unix.create_process !Config.alive2_bin
      [| !Config.alive2_bin; filename |]
      Unix.stdin
      (Unix.openfile alive2_log [ O_CREAT; O_WRONLY ] 0o640)
      Unix.stderr
  in
  Unix.waitpid [] pid |> ignore;

  (* review result *)
  let file = open_in alive2_log in
  let rec loop accu =
    try loop (input_line file :: accu) with End_of_file -> accu
  in
  (* FIXME: magic number *)
  let all_lines = loop [] |> List.rev |> List.filteri (fun i _ -> i < 6) in
  close_in file;
  let search src tgt =
    let re_tgt = Str.regexp_string tgt in
    try Str.search_forward re_tgt src 0 with Not_found -> -1
  in
  let rec aux accu = function
    | [] -> accu
    | hd :: tl ->
        if
          search hd "failed-to-prove transformations" = -1
          || hd |> String.split_on_char ' ' |> Fun.flip List.nth 0
             |> int_of_string = 0
        then
          if
            search hd "incorrect transformations" = -1
            || hd |> String.split_on_char ' ' |> Fun.flip List.nth 0
               |> int_of_string = 0
          then aux accu tl
          else INVALID
        else CRASH
  in
  aux VALID all_lines

(* run opt (and tv) and measure coverage *)
let run llm =
  (* reset all previous coverages *)
  (* FIXME: magic path *)
  Sys.command
    ("find "
    ^ concat_home "./llvm-project/build/"
    ^ " -type f -name '*.gcda' | xargs rm")
  |> ignore;

  count := !count + 1;
  let output_name = Filename.concat !Config.out_dir (ll_of_count ()) in
  Llvm.print_module output_name llm;

  (* run opt/alive2 and evaluate *)
  if !Config.no_tv then (
    let exit_code =
      Sys.command (!Config.opt_bin ^ " -S --passes=instcombine " ^ output_name)
    in
    let crashed = exit_code <> 0 in
    if crashed then
      Llvm.print_module (Filename.concat !Config.crash_dir (ll_of_count ())) llm;
    ((if crashed then CRASH else VALID), get_coverage ()))
  else
    let alive2_result = run_alive2 output_name in
    if alive2_result <> VALID then
      Llvm.print_module (Filename.concat !Config.crash_dir (ll_of_count ())) llm;
    (alive2_result, get_coverage ())

let rec fuzz pool cov =
  let seed, pool_popped = SeedPool.pop pool in

  (* each mutant is mutated m times *)
  let mutate_seed (pool, cov) =
    let mutant =
      Utils.repeat_fun (Mutation.run llctx) seed !Config.num_mutation
    in
    (* TODO: not using run result, only caring coverage *)
    let _, cov_mutant = run mutant in
    let pool' =
      if LineCoverage.subset cov cov_mutant then pool
      else SeedPool.push mutant pool
    in
    let cov' = LineCoverage.join cov cov_mutant in

    (* timestamp *)
    if now () - !recent_time > !Config.log_time then (
      recent_time := now ();
      output_string timestamp_fp
        (string_of_int (now () - !start_time)
        ^ " "
        ^ string_of_int (LineCoverage.total_cardinal cov')
        ^ "\n"));
    (pool', cov')
  in

  (* each seed is mutated into n mutants *)
  let pool', cov' =
    Utils.repeat_fun mutate_seed (pool_popped, cov) !Config.num_mutant
  in

  (* repeat until the time budget or seed pool exhausts *)
  if now () - !start_time > !Config.time_budget || SeedPool.cardinal pool' = 0
  then cov'
  else fuzz pool' cov'

let main () =
  initialize ();
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#seeds: %d\n" (SeedPool.cardinal seed_pool);

  start_time := now ();
  let coverage = fuzz seed_pool LineCoverage.empty in
  let end_time = now () in

  Sys.command "rm *.gcov" |> ignore;
  if not !Config.no_tv then Unix.unlink alive2_log;

  F.printf "total coverage: %d lines\n" (LineCoverage.total_cardinal coverage);
  F.printf "time spend: %ds\n" (end_time - !start_time)

let _ = main ()
