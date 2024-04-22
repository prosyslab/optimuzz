open Util.ALlvm
module L = Logger
module F = Format

(* llfuzz directory which includes src/, README.md, etc. Automatically set. *)
let project_home = ref ""

(* paths *)
let pattern_path = ref ""
let cov_tgt_path = ref ""
let seed_dir = ref "seed"
let out_dir = ref "llfuzz-out"
let crash_dir = ref "crash"
let corpus_dir = ref "corpus"
let cov_file = ref "cov.cov"
let gcov_dir = ref "gcov"
let dry_run = ref false

(* build/binaries *)
(* let opt_bin = ref "llvm-project/build/bin/opt" *)
let opt_bin = ref "./opt"
let alive_tv_bin = ref "Alive2/alive2/build/alive-tv"

(* seed options *)
let max_initial_seed = ref 100
let random_seed = ref 0
let max_distance = ref (1 lsl 16) (* 2 ^ 16 *)

(* fuzzing options *)
let time_budget = ref (-1)
let cov_directed = ref ""
let num_mutation = ref 10
let num_mutant = ref 1
let no_tv = ref false
let metric = ref "avg"
let log_level = ref "error"

(* mutation options *)
let interesting_integers =
  ref [ 0; 1; 2; 255 (*0xFF*); 65535 (*0xFFFF*); 4294967295 (* 0xFFFFFFFF *) ]

let interesting_integer_types = ref []
let interesting_vector_types = ref []
let interesting_types = ref []

let set_interesting_types llctx =
  interesting_integer_types :=
    [
      integer_type llctx 1;
      integer_type llctx 4;
      (* 72911 *)
      integer_type llctx 8;
      integer_type llctx 10;
      integer_type llctx 32;
      integer_type llctx 34;
      integer_type llctx 64;
    ];
  interesting_vector_types :=
    [
      vector_type (i1_type llctx) 1;
      vector_type (i1_type llctx) 4;
      vector_type (i8_type llctx) 1;
      vector_type (i8_type llctx) 4;
      vector_type (i32_type llctx) 1;
      vector_type (i32_type llctx) 4;
    ];
  interesting_types := !interesting_integer_types @ !interesting_vector_types

(* logging options *)
let log_time = ref 30

(* whitelist
   refer to: https://llvm.org/docs/Passes.html *)
let _instCombine = ref true

let opts =
  [
    (* if these two are set, branch to other operation (not fuzzing) *)
    ( "-pattern",
      Arg.Set_string pattern_path,
      "To generate programs of certain patterns" );
    ( "-coverage",
      Arg.Set_string cov_tgt_path,
      "To measure opt coverage only over the file" );
    (* paths *)
    ("-seed-dir", Arg.Set_string seed_dir, "Seed program directory");
    ("-out-dir", Arg.Set_string out_dir, "Output directory");
    ("-opt-bin", Arg.Set_string opt_bin, "Path to opt executable");
    ("-tv-bin", Arg.Set_string alive_tv_bin, "Path to alive-tv executable");
    (* fuzzing options *)
    ("-random-seed", Arg.Set_int random_seed, "Set random seed");
    ("-limit", Arg.Set_int time_budget, "Time budget (limit in seconds)");
    ("-direct", Arg.Set_string cov_directed, "Target coverage id");
    ("-n-mutation", Arg.Set_int num_mutation, "Each mutant is mutated m times.");
    ("-n-mutant", Arg.Set_int num_mutant, "Each seed is mutated into n mutants.");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
    ("-metric", Arg.Set_string metric, "Metric to give a score to a coverage");
    (* logging options *)
    ("-log-time", Arg.Set_int log_time, "Change timestamp interval");
    ("-log-level", Arg.Set_string log_level, "Set log level. Defaults to info. ");
    ( "-dry-run",
      Arg.Set dry_run,
      "Do not run fuzzing. (for testing configuration)" );
    (* gcov whitelist *)
    ( "-instcombine",
      Arg.Set _instCombine,
      "[register whitelist] Combine instructions to form fewer, simple \
       instructions" );
  ]

(* * only called after arguments are parsed. *)
(* TODO: is there optimization files other than ones under Transforms? *)
let to_gcda category code =
  Filename.concat !project_home
    ("llvm-project/build/lib/Transforms/" ^ category ^ "/CMakeFiles/LLVM"
   ^ category ^ ".dir/" ^ code ^ ".cpp.gcda")

let to_gcov code = !gcov_dir ^ "/" ^ code ^ ".cpp.gcov"

(* whitelist members *)

let instCombine =
  ( "InstCombine",
    [
      "InstCombineVectorOps";
      "InstCombineSelect";
      "InstCombineMulDivRem";
      "InstCombineAddSub";
      "InstCombineSimplifyDemanded";
      "InstCombineCalls";
      "InstCombineCasts";
      "InstCombineCompares";
      "InstCombineAtomicRMW";
      "InstCombineShifts";
      "InstCombineAndOrXor";
      "InstructionCombining";
      "InstCombineNegator";
      "InstCombinePHI";
      "InstCombineLoadStoreAlloca";
    ] )

let optimizations = [ (_instCombine, instCombine) ]

(* Followings are lazy properties;
   they are not and must not be used
   before the command line arguments are parsed. *)

let whitelist = ref []

let init_whitelist () =
  optimizations
  |> List.filter (fun elem -> !(fst elem))
  |> List.map (fun elem -> snd elem)
  |> fun x -> whitelist := x

let gcda_list = ref []

let init_gcda_list () =
  !whitelist
  |> List.map (fun elem ->
         let category = fst elem in
         List.map (fun code -> to_gcda category code) (snd elem))
  |> List.concat
  |> fun x -> gcda_list := x

let gcov_list = ref []

let init_gcov_list () =
  !whitelist
  |> List.map (fun elem -> List.map to_gcov (snd elem))
  |> List.concat
  |> fun x -> gcov_list := x

let initialize llctx () =
  Arg.parse opts
    (fun _ -> failwith "no anonymous arguments")
    "Usage: llfuzz [options]";

  (* consider dune directory *)
  project_home :=
    Sys.argv.(0)
    |> Unix.realpath
    |> Filename.dirname
    |> Filename.dirname
    |> Filename.dirname
    |> Filename.dirname;

  opt_bin := Filename.concat !project_home !opt_bin;
  alive_tv_bin := Filename.concat !project_home !alive_tv_bin;

  if Sys.file_exists !opt_bin |> not then
    failwith ("opt binary not found: " ^ !opt_bin);
  if Sys.file_exists !alive_tv_bin |> not then
    failwith ("alive-tv binary not found: " ^ !alive_tv_bin);

  out_dir := Filename.concat !project_home !out_dir;
  crash_dir := Filename.concat !out_dir !crash_dir;
  corpus_dir := Filename.concat !out_dir !corpus_dir;

  (* make directories first *)
  (try Sys.mkdir !out_dir 0o755
   with Sys_error msg ->
     (* Check if corpus and crash directory are there already *)
     if Sys.file_exists !corpus_dir && Sys.file_exists !crash_dir then (
       F.eprintf "%s@." msg;
       F.eprintf "It seems like the output directory already exists.@.";
       F.eprintf "We don't want to mess up with existing files. Exiting...@.";
       exit 0)
     else ());
  (try Sys.mkdir !crash_dir 0o755 with _ -> ());
  (try Sys.mkdir !corpus_dir 0o755 with _ -> ());

  if !cov_directed = "" then
    failwith "Coverage target is not set. Please set -direct option.";

  L.from_file (Filename.concat !out_dir "fuzz.log");
  (match !log_level with
  | "debug" -> L.set_level L.DEBUG
  | "info" -> L.set_level L.INFO
  | "warn" -> L.set_level L.WARN
  | "error" -> L.set_level L.ERROR
  | _ -> failwith "Invalid log level");

  opts
  |> List.iter (fun (name, spec, _) ->
         match spec with
         | Arg.Set b -> L.info "%s: %b" name !b
         | Arg.Set_string s -> L.info "%s: %s" name !s
         | Arg.Set_int i -> L.info "%s: %d" name !i
         | _ -> failwith "not implemented");

  L.flush ();

  set_interesting_types llctx;

  if !dry_run then
    opts
    |> List.iter (fun (name, spec, _) ->
           match spec with
           | Arg.Set b -> Format.printf "%s: %b\n" name !b
           | Arg.Set_string s -> Format.printf "%s: %s\n" name !s
           | Arg.Set_int i -> Format.printf "%s: %d\n" name !i
           | _ -> failwith "not implemented")
