open Coverage.Domain
open Coverage.Gcov
module F = Format

type res_t = CRASH | INVALID | VALID

let llctx = Llvm.create_context ()
let count = ref 0

(* for logging *)
let alive2_log = "alive-tv.txt"
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp

(* helpers *)
let concat_home = Filename.concat !Config.project_home

let new_ll () =
  count := !count + 1;
  string_of_int !count ^ ".ll"

let name_opted_ver filename =
  if String.ends_with ~suffix:".ll" filename then
    String.sub filename 0 (String.length filename - 3) ^ ".opt.ll"
  else filename ^ ".opt.ll"

let now () = Unix.time () |> int_of_float
let command_args args = args |> String.concat " " |> Sys.command

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
  let filename = Filename.concat !Config.out_dir filename in
  let exit_state =
    command_args
      [
        !Config.alive2_bin;
        filename;
        name_opted_ver filename;
        "| tail -n 4 >";
        alive2_log;
      ]
  in

  (* review result *)
  if exit_state <> 0 then CRASH
  else
    let file = open_in alive2_log in
    let rec loop accu =
      match input_line file with
      | exception End_of_file -> accu
      | line -> loop (line :: accu)
    in
    let lines = [] |> loop |> List.rev in
    close_in file;

    let is_num_zero str =
      str |> String.trim |> String.split_on_char ' ' |> List.hd |> int_of_string
      = 0
    in
    let str_incorrect = List.nth lines 1 in
    if is_num_zero str_incorrect then VALID else INVALID

let run_opt filename =
  let filename = Filename.concat !Config.out_dir filename in
  let exit_state =
    command_args
      [
        !Config.opt_bin;
        filename;
        "-S";
        "--passes=instcombine";
        "-o";
        name_opted_ver filename;
      ]
  in
  if exit_state = 0 then VALID else CRASH

let save_ll dir filename llm =
  let output_name = Filename.concat dir filename in
  Llvm.print_module output_name llm

(* run opt (and tv) and measure coverage *)
let run filename llm =
  clean ();
  save_ll !Config.out_dir filename llm;

  (* run opt/alive2 and evaluate *)
  let coverage = Coverage.Gcov.run () in
  let res_opt = run_opt filename in
  if !Config.no_tv then (
    if res_opt = CRASH then save_ll !Config.crash_dir filename llm;
    (res_opt, coverage))
  else
    let res_alive2 = run_alive2 filename in
    if res_alive2 <> VALID then
      Llvm.print_module (Filename.concat !Config.crash_dir (new_ll ())) llm;
    (res_alive2, coverage)

let rec fuzz pool cov gen_count =
  let seed, pool_popped = SeedPool.pop pool in
  (* each mutant is mutated m times *)
  let mutate_seed (pool, cov, gen_count) =
    let mutant =
      Util.LUtil.repeat_fun
        (Mutation.Mutator.run llctx)
        seed !Config.num_mutation
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
  if !Config.pattern_path <> "" then (
    let name, pat = !Config.pattern_path |> Pattern.Parser.run in
    let all_instances = Pattern.Instantiation.run name pat in
    List.iter (Llvm.print_module (new_ll ())) all_instances;
    exit 0);

  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

  start_time := now ();
  let coverage = fuzz seed_pool LineCoverage.empty 0 in
  let end_time = now () in

  Sys.command "rm *.gcov" |> ignore;
  if not !Config.no_tv then Unix.unlink alive2_log;

  F.printf "total coverage: %d lines@." (LineCoverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !start_time)

let _ = main ()
