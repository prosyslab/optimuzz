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

let new_ll () =
  count := !count + 1;
  string_of_int !count ^ ".ll"

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
  Config.crash_dir := Filename.concat !Config.out_dir !Config.crash_dir;
  Config.corpus_dir := Filename.concat !Config.out_dir !Config.corpus_dir;
  (* these files are bound to (outer) workspace *)
  (try Sys.mkdir !Config.out_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.gcov_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.crash_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.corpus_dir 0o755 with _ -> ());
  Config.init_whitelist ();
  Config.init_gcda_list ();
  Config.init_gcov_list ();
  Random.init !Config.random_seed

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

let run_opt filename =
  let filename = Filename.concat !Config.out_dir filename in
  Sys.command
    (!Config.opt_bin ^ " -S --passes=instcombine -o /dev/null " ^ filename)

let save_ll dir filename llm =
  let output_name = Filename.concat dir filename in
  Llvm.print_module output_name llm

(* run opt (and tv) and measure coverage *)
let run filename llm =
  (* reset all previous coverages *)
  (* FIXME: magic path *)
  Sys.command
    ("find "
    ^ concat_home "./llvm-project/build/"
    ^ " -type f -name '*.gcda' | xargs rm")
  |> ignore;

  save_ll !Config.out_dir filename llm;

  (* run opt/alive2 and evaluate *)
  if !Config.no_tv then (
    let exit_code = run_opt filename in
    let crashed = exit_code <> 0 in
    if crashed then save_ll !Config.crash_dir filename llm;
    ((if crashed then CRASH else VALID), Gcov.get_coverage ()))
  else
    let alive2_result = run_alive2 filename in
    if alive2_result <> VALID then
      Llvm.print_module (Filename.concat !Config.crash_dir (new_ll ())) llm;
    (alive2_result, Gcov.get_coverage ())

let rec fuzz pool cov gen_count =
  let seed, pool_popped = SeedPool.pop pool in
  (* each mutant is mutated m times *)
  let mutate_seed (pool, cov, gen_count) =
    let mutant =
      Util.LUtil.repeat_fun (Mutation.run llctx) seed !Config.num_mutation
    in
    let filename = new_ll () in
    (* TODO: not using run result, only caring coverage *)
    let _, cov_mutant = run filename mutant in

    let pool', cov', gen_count =
      if LineCoverage.subset cov_mutant cov then (pool, cov, gen_count)
      else
        let _ = save_ll !Config.corpus_dir filename mutant in
        let seed = SeedPool.push mutant pool in
        let cov = LineCoverage.join cov cov_mutant in
        F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
          (gen_count + 1)
          (LineCoverage.cardinal cov);
        (seed, cov, gen_count + 1)
    in

    (* timestamp *)
    if now () - !recent_time > !Config.log_time then (
      recent_time := now ();
      output_string timestamp_fp
        (string_of_int (now () - !start_time)
        ^ " "
        ^ string_of_int (LineCoverage.cardinal cov')
        ^ "\n"));
    (pool', cov', gen_count)
  in

  (* each seed is mutated into n mutants *)
  let pool', cov', gen_count =
    Util.LUtil.repeat_fun mutate_seed
      (pool_popped, cov, gen_count)
      !Config.num_mutant
  in
  let pool' = SeedPool.push seed pool' in
  (* repeat until the time budget or seed pool exhausts *)
  if !Config.time_budget > 0 && now () - !start_time > !Config.time_budget then
    cov'
  else fuzz pool' cov' gen_count

let main () =
  initialize ();
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

  (* TODO: merge this pathway into main fuzzing *)
  if !Config.pattern_path <> "" then (
    let name, pat = !Config.pattern_path |> Pattern.Parser.run |> List.hd in
    Pattern.Instantiation.run name pat |> Llvm.print_module "test.ll";
    exit 0);

  start_time := now ();
  let coverage = fuzz seed_pool LineCoverage.empty 0 in
  let end_time = now () in

  Sys.command "rm *.gcov" |> ignore;
  if not !Config.no_tv then Unix.unlink alive2_log;

  F.printf "total coverage: %d lines@." (LineCoverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !start_time)

let _ = main ()
