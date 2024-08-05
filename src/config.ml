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
let json_file = ref "cov.json"
let dry_run = ref false

(* binary dependencies *)
let opt_bin = ref "opt"
let alive_tv_bin = ref "alive-tv"

(* seed options *)
let max_initial_seed = ref 100
let random_seed = ref 0
let max_distance = ref (1 lsl 16) (* 2 ^ 16 *)

(* fuzzing options *)

type metric = Min_metric | Avg_metric
type queue_type = Priority_queue | Fifo_queue

(** seedpool construction configuration *)
type seedpool_opt =
  | Fresh
      (** Start fuzzing campaign from scratch.
     It will
     (1) check if opt fails and run llmodule cleaning ([Seedcorpus.Prep.clean_llm])
     (2) measure distances for each seed and construct seedpool.
     It requires initial seed directory (-seed-dir) *)
  | SkipClean
      (** Start fuzzing campaign without checking if opt fails and llmodule cleaning.
     it requires initial seed directory which contains preprocessed llmodules.
     The fuzzing campaign will start after a seedpool is constructed from the initial seed directory.
     Safety: one should ensure that the files are already preprocessed *)
  | Resume
      (** Resume fuzzing campaign with current corpus and crash directory.
 The fuzzing campaign will start after a seedpool is constructed from the current corpus and crash directory. *)

let seedpool_option = ref Fresh

(* string_of_types *)
let string_of_metric = function Min_metric -> "min" | Avg_metric -> "avg"

let string_of_queue_type = function
  | Priority_queue -> "priority"
  | Fifo_queue -> "fifo"

let string_of_seedpool_option = function
  | Fresh -> "fresh"
  | SkipClean -> "skip-clean"
  | Resume -> "resume"

let string_of_level = function
  | L.DEBUG -> "DEBUG"
  | L.INFO -> "INFO"
  | L.WARN -> "WARN"
  | L.ERROR -> "ERROR"

(* default *)
let time_budget = ref (-1)

module Mode = struct
  type t = Blackbox | Greybox | Directed of string

  let string_of = function
    | Blackbox -> "blackbox"
    | Greybox -> "greybox"
    | Directed s -> "directed: " ^ s

  let of_string s =
    match s with
    | "blackbox" -> Blackbox
    | "greybox" -> Greybox
    | _ ->
        (* if starts with directed: *)
        if String.length s >= 9 && String.sub s 0 9 = "directed:" then
          Directed (String.sub s 9 (String.length s - 9))
        else failwith "Invalid mode"
end

let mode = ref Mode.Blackbox

(* optimizer options *)

let optimizer_passes =
  (* ref [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ] *)
  ref [ "instcombine" ]

let num_mutation = ref 1
let num_mutant = ref 1
let no_tv = ref false
let record_cov = ref false
let metric = ref Min_metric
let queue = ref Fifo_queue
let no_learn = ref true
let learn_inc = ref 20
let learn_dec = ref 5
let log_level = ref L.ERROR

(* mutation options *)

module Interests = struct
  type t = Normal of string | Undef | Poison

  (* mutation options *)
  let interesting_integers =
    ref
      [
        Normal "-1";
        Normal "0";
        Normal "1";
        Normal "2";
        Normal "16";
        Normal "255" (*0xFF*);
        Normal "65535" (*0xFFFF*);
        Normal "4294967295" (* 0xFFFFFFFF *);
        Undef;
        Poison;
      ]

  let interesting_vectors =
    ref
      [
        [| Normal "0" |];
        [| Normal "1" |];
        [| Normal "-1" |];
        [| Normal "0"; Normal "1" |];
        [| Undef; Normal "-1" |];
        [| Normal "-1"; Poison |];
        [| Poison; Normal "0" |];
        [| Normal "0"; Undef; Undef |];
        [| Normal "-1"; Normal "-1"; Normal "-1"; Poison |];
        [| Normal "0"; Normal "0"; Normal "0"; Normal "0" |];
        [| Normal "0"; Normal "1"; Normal "2"; Normal "3" |];
        [| Normal "0"; Undef; Undef; Normal "3" |];
      ]

  let interesting_integer_types = ref []
  let interesting_vector_types = ref []
  let interesting_types = ref []

  let set_interesting_types llctx =
    interesting_integer_types :=
      [
        integer_type llctx 1;
        integer_type llctx 4;
        integer_type llctx 8;
        integer_type llctx 10;
        integer_type llctx 32;
        integer_type llctx 34;
        integer_type llctx 64;
        integer_type llctx 128;
      ];
    interesting_vector_types :=
      [
        vector_type (i1_type llctx) 1;
        vector_type (i1_type llctx) 4;
        vector_type (i8_type llctx) 1;
        vector_type (i8_type llctx) 4;
        vector_type (i16_type llctx) 2;
        vector_type (i16_type llctx) 3;
        vector_type (i32_type llctx) 1;
        vector_type (i32_type llctx) 2;
        vector_type (i32_type llctx) 4;
      ];
    interesting_types := !interesting_integer_types @ !interesting_vector_types
end

(* whitelist
   refer to: https://llvm.org/docs/Passes.html *)
let _instCombine = ref true

let env_opts =
  [
    ("-seed-dir", Arg.Set_string seed_dir, "Seed program directory");
    ("-out-dir", Arg.Set_string out_dir, "Output directory");
    ("-opt-bin", Arg.Set_string opt_bin, "Path to opt executable");
    ("-tv-bin", Arg.Set_string alive_tv_bin, "Path to alive-tv executable");
  ]

let fuzzing_opts =
  [
    ( "-mode",
      Arg.String (fun s -> mode := Mode.of_string s),
      "(blackbox, greybox, directed:<path>)" );
    ("-n-mutation", Arg.Set_int num_mutation, "Each mutant is mutated m times.");
    ("-n-mutant", Arg.Set_int num_mutant, "Each seed is mutated into n mutants.");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
    (* ("-no-learn", Arg.Set no_learn, "Turn off mutation learning");
       ( "-learn-inc",
         Arg.Set_int learn_inc,
         "Reward for correct mutation during learning" );
       ( "-learn-dec",
         Arg.Set_int learn_dec,
         "Penalty for incorrect mutation during learning" ); *)
    ( "-metric",
      Arg.String
        (function
        | "min" -> metric := Min_metric
        | "avg" -> metric := Avg_metric
        | _ -> failwith "Invalid metric"),
      "Metric to give a score to an AST coverage" );
    ( "-queue",
      Arg.String
        (function
        | "priority" -> queue := Priority_queue
        | "fifo" -> queue := Fifo_queue
        | _ -> failwith "Invalid queue"),
      "Queue type of the seed pool (priority, fifo)" );
  ]

let other_opts =
  [
    ( "-passes",
      Arg.String
        (function s -> optimizer_passes := String.split_on_char ',' s),
      "Set opt passes" );
    ( "-log-level",
      Arg.String
        (function
        | "info" -> log_level := L.INFO
        | "warn" -> log_level := L.WARN
        | "error" -> log_level := L.ERROR
        | "debug" -> log_level := L.DEBUG
        | _ -> failwith "Invalid log level"),
      "Set log level. Defaults to info. " );
    ( "-dry-run",
      Arg.Set dry_run,
      "Do not run fuzzing. (for testing configuration)" );
  ]

let opts =
  env_opts @ fuzzing_opts @ other_opts
  @ [
      (* if these two are set, branch to other operation (not fuzzing) *)
      (* ( "-pattern",
           Arg.Set_string pattern_path,
           "To generate programs of certain patterns" );
         ( "-coverage",
           Arg.Set_string cov_tgt_path,
           "To measure opt coverage only over the file" ); *)
      (* paths *)
      (* ( "-seedpool",
         Arg.String
           (function
           | "fresh" -> seedpool_option := Fresh
           | "skip-clean" -> seedpool_option := SkipClean
           | "resume" -> seedpool_option := Resume
           | _ -> failwith "Invalid start option"),
         "Start option" ); *)
      ("-record-cov", Arg.Set record_cov, "Recording all coverage");
      (* gcov whitelist *)
      (* ( "-instcombine",
         Arg.Set _instCombine,
         "[register whitelist] Combine instructions to form fewer, simple \
          instructions" ); *)
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

type dependencies = { opt : string; alive_tv : string }
type output = { out : string; crash : string; corpus : string }

let lookup_dependencies cwd =
  let opt = Filename.concat cwd !opt_bin in
  let alive_tv = Filename.concat cwd !alive_tv_bin in

  if Sys.file_exists opt |> not then failwith ("opt binary not found: " ^ opt);

  if Sys.file_exists alive_tv |> not then
    failwith ("alive-tv binary not found: " ^ alive_tv);

  { opt; alive_tv }

let setup_output cwd out_dir =
  (* cwd / llfuzz-out *)
  let out = Filename.concat cwd out_dir in
  (* cwd / llfuzz-out / crash *)
  let crash = Filename.concat out !crash_dir in
  (* cwd / llfuzz-out / corpus *)
  let corpus = Filename.concat out !corpus_dir in

  if
    !seedpool_option <> Resume
    && (Sys.file_exists crash || Sys.file_exists corpus)
  then (
    F.eprintf "It seems like the output directory already exists.@.";
    F.eprintf "We don't want to mess up with existing files. Exiting...@.";
    exit 0);

  (try Sys.mkdir out 0o755 with _ -> ());
  (try Sys.mkdir crash 0o755 with _ -> ());
  (try Sys.mkdir corpus 0o755 with _ -> ());

  { out; crash; corpus }

let log_options opts =
  opts
  |> List.iter (fun (name, spec, _) ->
         match spec with
         | Arg.Set b -> L.info "%s: %b" name !b
         | Arg.Set_string s -> L.info "%s: %s" name !s
         | Arg.Set_int i -> L.info "%s: %d" name !i
         | Arg.String _ when name = "-metric" ->
             L.info "%s: %s" name (string_of_metric !metric)
         | Arg.String _ when name = "-queue" ->
             L.info "%s: %s" name (string_of_queue_type !queue)
         | Arg.String _ when name = "-log-level" ->
             L.info "%s: %s" name (string_of_level !log_level)
         | Arg.String _ when name = "-passes" ->
             L.info "%s: %s " name (String.concat "," !optimizer_passes)
         | Arg.String _ when name = "-seedpool" ->
             L.info "%s: %s" name (string_of_seedpool_option !seedpool_option)
         | Arg.String _ when name = "-mode" ->
             L.info "%s: %s" name (Mode.string_of !mode)
         | _ -> failwith "not implemented");

  L.flush ()

let initialize llctx () =
  Arg.parse opts
    (fun _ -> failwith "no anonymous arguments")
    "Usage: llfuzz [options]";

  (* consider dune directory *)
  (* it locates the execution binary. not suitable for setting up for many running environment *)
  project_home :=
    Sys.argv.(0)
    |> Unix.realpath
    |> Filename.dirname
    |> Filename.dirname
    |> Filename.dirname
    |> Filename.dirname;

  let cwd = Sys.getcwd () in

  let { opt; alive_tv } = lookup_dependencies cwd in
  opt_bin := opt;
  alive_tv_bin := alive_tv;

  let { out; crash; corpus } = setup_output cwd !out_dir in
  out_dir := out;
  crash_dir := crash;
  corpus_dir := corpus;

  L.from_file (Filename.concat !out_dir "fuzz.log");
  L.set_level !log_level;
  log_options opts;

  if Sys.file_exists !seed_dir |> not then
    failwith ("Seed directory not found: " ^ !seed_dir);

  Interests.set_interesting_types llctx
