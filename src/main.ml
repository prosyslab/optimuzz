open Coverage.Domain
module F = Format

type res_t = CRASH | INVALID | VALID

let llctx = Llvm.create_context ()

(* alias *)
let cmd = Util.LUtil.command_args

(* for logging *)
let alive2_log = "alive-tv.txt"
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp
let now () = Unix.time () |> int_of_float
let count = ref 0

let get_new_name () =
  count := !count + 1;
  string_of_int !count ^ ".ll"

let name_opted_ver filename =
  if String.ends_with ~suffix:".ll" filename then
    String.sub filename 0 (String.length filename - 3) ^ ".opt.ll"
  else filename ^ ".opt.ll"

let save_ll dir filename llm =
  let output_name = Filename.concat dir filename in
  Llvm.print_module output_name llm

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

  (* consider dune directory *)
  Config.project_home :=
    Sys.argv.(0) |> Unix.realpath |> Filename.dirname |> Filename.dirname
    |> Filename.dirname |> Filename.dirname;

  Config.opt_bin := Filename.concat !Config.project_home !Config.opt_bin;
  Config.alive2_bin := Filename.concat !Config.project_home !Config.alive2_bin;

  Config.out_dir := Filename.concat !Config.project_home !Config.out_dir;
  Config.crash_dir := Filename.concat !Config.out_dir !Config.crash_dir;
  Config.corpus_dir := Filename.concat !Config.out_dir !Config.corpus_dir;

  (* make directories first *)
  (try Sys.mkdir !Config.out_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.crash_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.corpus_dir 0o755 with _ -> ());

  Random.init !Config.random_seed;

  (* Clean previous coverage data *)
  Coverage.Measurer.clean ()

let run_alive2 filename =
  (* run alive2 *)
  let exit_state =
    cmd
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
  let exit_state =
    cmd
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

(* run opt (and tv) and measure coverage *)
let run_bins filename llm =
  Coverage.Measurer.clean ();
  save_ll !Config.out_dir filename llm;
  let filename_out = Filename.concat !Config.out_dir filename in

  (* run opt/alive2 and evaluate *)
  let res_opt = run_opt filename_out in
  let coverage = Coverage.Measurer.run () in
  if !Config.no_tv then (
    if res_opt <> VALID then save_ll !Config.crash_dir filename llm;
    (res_opt, coverage))
  else
    let res_alive2 = run_alive2 filename_out in
    if res_alive2 <> VALID then save_ll !Config.crash_dir filename llm;
    (res_alive2, coverage)

let rec fuzz pool cov gen_count =
  let seed, pool_popped = SeedPool.pop pool in
  (* each mutant is mutated m times *)
  let mutate_seed (pool, cov, gen_count) =
    let mutant = Mutation.Mutator.run llctx !Config.num_mutation seed in
    let filename = get_new_name () in
    (* TODO: not using run result, only caring coverage *)
    let _, cov_mutant = run_bins filename mutant in

    let pool', cov', gen_count =
      if CovMap.subset cov_mutant cov then (pool, cov, gen_count)
      else (
        save_ll !Config.corpus_dir filename mutant;
        let seed = SeedPool.push mutant pool in
        let cov = CovMap.join cov cov_mutant in
        F.printf "\r#newly generated seeds: %d, total coverge: %d@?"
          (gen_count + 1) (CovMap.cardinal cov);
        (seed, cov, gen_count + 1))
    in

    (* timestamp *)
    if now () - !recent_time > !Config.log_time then (
      recent_time := now ();
      output_string timestamp_fp
        (string_of_int (now () - !start_time)
        ^ " "
        ^ string_of_int (CovMap.cardinal cov')
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

  (* pattern *)
  if !Config.pattern_path <> "" then (
    let name, pat = !Config.pattern_path |> Pattern.Parser.run in
    let all_instances = Pattern.Instantiation.run name pat in
    List.iter (save_ll !Config.out_dir (get_new_name ())) all_instances;
    exit 0);

  (* measure coverage *)
  if !Config.cov_tgt_path <> "" then (
    run_opt !Config.cov_tgt_path |> ignore;
    let cov = Coverage.Measurer.run () in
    print_string "Total coverage: ";
    cov |> CovMap.cardinal |> string_of_int |> print_endline;
    exit 0);

  (* fuzzing *)
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

  start_time := now ();
  let coverage = fuzz seed_pool CovMap.empty 0 in
  let end_time = now () in

  if not !Config.no_tv then Unix.unlink alive2_log;

  F.printf "\ntotal coverage: %d lines@." (CovMap.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !start_time)

let _ = main ()
