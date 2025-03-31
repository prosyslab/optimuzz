open Util.ALlvm
module L = Logger
module F = Format

(* paths *)
let seed_dir = ref "seed"
let out_dir = ref "llfuzz-out"
let crash_dir = ref "crash"
let corpus_dir = ref "corpus"
let covers_dir = ref "covers"
let muts_dir = ref "muts"
let cov_file = ref "cov.cov"
let dry_run = ref false

(* binary dependencies *)
let opt_bin = ref "opt"
let alive_tv_bin = ref "alive-tv"

(* seed options *)
let max_initial_seed = ref 50
let random_seed = ref 0
let max_distance = ref (1 lsl 16) (* 2 ^ 16 *)

(* fuzzing options *)

let string_of_level = function
  | L.DEBUG -> "DEBUG"
  | L.INFO -> "INFO"
  | L.WARN -> "WARN"
  | L.ERROR -> "ERROR"

module FuzzingMode = struct
  (** Baseline: (All_edges, Constant, Uniform)
      Next: (All_edges, By_distance, Uniform)
      Next: (Slice_cfg, By_distance, Uniform)
      Next: (Slice_cfg, By_distance, Focused)
  *)
  type coverage_t = All_edges | Sliced_cfg

  type score_t = Constant | By_distance | Aflgo
  type mutation_t = Uniform | Focused
end

let coverage = ref FuzzingMode.Sliced_cfg

(** a file of target blocks for cfg slicing and distance calculation *)
let target_blocks_file = ref ""

let cfg_dir = ref ""
let score = ref FuzzingMode.By_distance
let mutation = ref FuzzingMode.Focused

let string_of_coverage_option = function
  | FuzzingMode.All_edges -> "all"
  | FuzzingMode.Sliced_cfg -> "sliced"

let string_of_score_option = function
  | FuzzingMode.Constant -> "constant"
  | FuzzingMode.By_distance -> "distance"
  | FuzzingMode.Aflgo -> "aflgo"

let string_of_mutation_option = function
  | FuzzingMode.Uniform -> "uniform"
  | FuzzingMode.Focused -> "focused"

(* ref [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ] *)

(* optimizer options *)
(* ref [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ] *)
let optimizer_passes = ref [ "instcombine" ]
let mtriple = ref ""
let num_mutation = ref 1
let num_mutant = ref 1
let no_tv = ref false
let record_cov = ref false
let log_level = ref L.INFO

(* mutation options *)

module Interests = struct
  type t =
    | Normal of string
    | Undef
    | Poison
    | Float of float
    | Intrinsic of string

  (* mutation options *)
  let interesting_integers =
    ref
      [
        Normal "-1";
        Normal "0";
        Normal "1";
        Normal "2";
        Normal "3";
        Normal "16";
        Normal "255" (*0xFF*);
        Normal "65535" (*0xFFFF*);
        Normal "4294967295" (* 0xFFFFFFFF *);
        Undef;
        Poison;
      ]

  let interesting_floats =
    ref [ Float 0.0; Float (-0.0); Float 1.0; Float (-1.0); Undef; Poison ]

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

  let interesting_unary_integer_intrinsics =
    ref [ Intrinsic "llvm.bitreverse"; Intrinsic "llvm.ctpop" ]

  let interesting_binary_integer_intrinsics =
    ref
      [
        Intrinsic "llvm.smax";
        Intrinsic "llvm.smin";
        Intrinsic "llvm.umax";
        Intrinsic "llvm.umin";
        Intrinsic "llvm.sadd_sat";
        Intrinsic "llvm.uadd_sat";
        Intrinsic "llvm.ssub_sat";
        Intrinsic "llvm.usub_sat";
        Intrinsic "llvm.sshl_sat";
        Intrinsic "llvm.ushl_sat";
      ]

  let interesting_unary_float_intrinsics =
    ref
      [
        Intrinsic "llvm.sqrt";
        Intrinsic "llvm.sin";
        Intrinsic "llvm.cos";
        Intrinsic "llvm.exp";
        Intrinsic "llvm.exp2";
        Intrinsic "llvm.log";
        Intrinsic "llvm.log10";
        Intrinsic "llvm.log2";
        Intrinsic "llvm.fabs";
        Intrinsic "llvm.floor";
        Intrinsic "llvm.ceil";
        Intrinsic "llvm.trunc";
        Intrinsic "llvm.rint";
        Intrinsic "llvm.nearbyint";
        Intrinsic "llvm.round";
        Intrinsic "llvm.roundeven";
        Intrinsic "llvm.canonicalize";
      ]

  let interesting_binary_float_intrinsics =
    ref
      [
        Intrinsic "llvm.pow";
        Intrinsic "llvm.minnum";
        Intrinsic "llvm.maxnum";
        Intrinsic "llvm.minimum";
        Intrinsic "llvm.maximum";
        Intrinsic "llvm.copysign";
      ]

  let interesting_integer_types = ref []
  let interesting_float_types = ref []
  let interesting_vector_types = ref []
  let interesting_integer_vector_types = ref []
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
    interesting_float_types :=
      [
        half_type llctx;
        float_type llctx;
        double_type llctx;
        (* x86fp80_type llctx; *)
        fp128_type llctx;
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
    interesting_integer_vector_types :=
      !interesting_integer_types @ !interesting_vector_types;
    interesting_types :=
      (pointer_type llctx :: !interesting_integer_types)
      @ !interesting_float_types
      @ !interesting_vector_types
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
    ( "-coverage",
      Arg.String
        (function
        | "sliced" -> coverage := FuzzingMode.Sliced_cfg
        | "all" -> coverage := FuzzingMode.All_edges
        | _ -> failwith "Invalid coverage"),
      "Coverage type (default: sliced)" );
    ( "-score",
      Arg.String
        (function
        | "constant" -> score := FuzzingMode.Constant
        | "distance" -> score := FuzzingMode.By_distance
        | "aflgo" -> score := FuzzingMode.Aflgo
        | _ -> failwith "Invalid score"),
      "Score type (default: distance)" );
    ( "-mutation",
      Arg.String
        (function
        | "uniform" -> mutation := FuzzingMode.Uniform
        | "focused" -> mutation := FuzzingMode.Focused
        | _ -> failwith "Invalid mutation"),
      "Mutation type (default: focused)" );
    ( "-targets",
      Arg.Set_string target_blocks_file,
      "Targets file for CFG-based directed fuzzing" );
    ( "-cfg-dir",
      Arg.Set_string cfg_dir,
      "CFG directory for CFG-based directed fuzzing" );
    ("-n-mutation", Arg.Set_int num_mutation, "Each mutant is mutated m times.");
    ("-n-mutant", Arg.Set_int num_mutant, "Each seed is mutated into n mutants.");
    ( "-no-tv",
      Arg.Set no_tv,
      "Do not translate-validate during a fuzzing campaign" );
  ]

let other_opts =
  [
    ( "-passes",
      Arg.String
        (function s -> optimizer_passes := String.split_on_char ',' s),
      "Set opt passes" );
    ("-mtriple", Arg.String (function s -> mtriple := s), "Set opt mtriple");
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

(*** DEPRECATED OPTIONS ***)

type metric = Min_metric | Avg_metric

let string_of_metric = function Min_metric -> "min" | Avg_metric -> "avg"

type queue_type = Priority_queue | Fifo_queue

let string_of_queue_type = function
  | Priority_queue -> "priority"
  | Fifo_queue -> "fifo"

let pattern_path = ref ""
let cov_tgt_path = ref ""
let gcov_dir = ref "gcov"
let json_file = ref "cov.json"
let metric = ref Min_metric
let queue = ref Fifo_queue
let no_learn = ref true
let learn_inc = ref 20
let learn_dec = ref 5
let random_seed = ref 0

let deprecated_opts =
  [
    ("-no-learn", Arg.Set no_learn, "Turn off mutation learning");
    ( "-learn-inc",
      Arg.Set_int learn_inc,
      "Reward for correct mutation during learning" );
    ( "-learn-dec",
      Arg.Set_int learn_dec,
      "Penalty for incorrect mutation during learning" );
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
    (* if these two are set, branch to other operation (not fuzzing) *)
    ( "-pattern",
      Arg.Set_string pattern_path,
      "To generate programs of certain patterns" );
    ( "-coverage",
      Arg.Set_string cov_tgt_path,
      "To measure opt coverage only over the file" );
    ("-record-cov", Arg.Set record_cov, "Recording all coverage");
    (* gcov whitelist *)
    ( "-instcombine",
      Arg.Set _instCombine,
      "[register whitelist] Combine instructions to form fewer, simple \
       instructions" );
    (* ( "-seedpool",
       Arg.String
         (function
         | "fresh" -> seedpool_option := Fresh
         | "skip-clean" -> seedpool_option := SkipClean
         | "resume" -> seedpool_option := Resume
         | _ -> failwith "Invalid start option"),
       "Start option" ); *)
  ]

(*** DEPRECATED OPTIONS END ***)

let opts = env_opts @ fuzzing_opts @ other_opts

(* Followings are lazy properties;
   they are not and must not be used
   before the command line arguments are parsed. *)

type dependencies = { opt : string; alive_tv : string }

type output = {
  out : string;
  crash : string;
  corpus : string;
  covers : string;
  muts : string;
}

let lookup_dependencies cwd =
  let opt = Filename.concat cwd !opt_bin in
  let alive_tv =
    if Filename.is_implicit !alive_tv_bin then Filename.concat cwd !alive_tv_bin
    else !alive_tv_bin
  in

  if Sys.file_exists opt |> not then failwith ("opt binary not found: " ^ opt);

  if (not !no_tv) && not (Sys.file_exists alive_tv) then
    failwith ("alive-tv binary not found: " ^ alive_tv);
  { opt; alive_tv }

let setup_output cwd out_dir =
  (* cwd / llfuzz-out *)
  let out = Filename.concat cwd out_dir in
  (* cwd / llfuzz-out / crash *)
  let crash = Filename.concat out !crash_dir in
  (* cwd / llfuzz-out / corpus *)
  let corpus = Filename.concat out !corpus_dir in
  (* cwd / llfuzz-out / corpus *)
  let covers = Filename.concat out !covers_dir in
  (* cwd / llfuzz-out / corpus *)
  let muts = Filename.concat out "muts" in

  if
    (not !dry_run)
    && (Sys.file_exists crash || Sys.file_exists corpus)
    && Sys.readdir corpus |> Array.length <> 0
  then (
    F.eprintf "It seems like the output directory already exists.@.";
    F.eprintf "We don't want to mess up with existing files. Exiting...@.";
    exit 0);

  (try Sys.mkdir out 0o755 with _ -> ());
  (try Sys.mkdir crash 0o755 with _ -> ());
  (try Sys.mkdir corpus 0o755 with _ -> ());
  (try Sys.mkdir covers 0o755 with _ -> ());
  (try Sys.mkdir muts 0o755 with _ -> ());

  { out; crash; corpus; covers; muts }

let log_options opts =
  opts
  |> List.iter (fun (name, spec, _) ->
         match spec with
         | Arg.Set b -> L.info "%s: %b" name !b
         | Arg.Set_string s -> L.info "%s: %s" name !s
         | Arg.Set_int i -> L.info "%s: %d" name !i
         | Arg.String _ when name = "-coverage" ->
             L.info "%s: %s" name (string_of_coverage_option !coverage)
         | Arg.String _ when name = "-score" ->
             L.info "%s: %s" name (string_of_score_option !score)
         | Arg.String _ when name = "-mutation" ->
             L.info "%s: %s" name (string_of_mutation_option !mutation)
         | Arg.String _ when name = "-queue" ->
             L.info "%s: %s" name (string_of_queue_type !queue)
         | Arg.String _ when name = "-log-level" ->
             L.info "%s: %s" name (string_of_level !log_level)
         | Arg.String _ when name = "-passes" ->
             L.info "%s: %s " name (String.concat "," !optimizer_passes)
         | Arg.String _ when name = "-mtriple" -> L.info "%s: %s " name !mtriple
         | _ -> L.info "%s: <unset>" name);

  L.flush ()

let initialize llctx () =
  (* consider dune directory *)
  (* it locates the execution binary. not suitable for setting up for many running environment *)
  Arg.parse opts
    (fun _ -> failwith "no anonymous arguments")
    "Usage: llfuzz [options]";

  assert (Sys.file_exists !target_blocks_file);
  assert (Sys.file_exists !cfg_dir);
  assert (Sys.is_directory !target_blocks_file |> not);
  assert (Sys.is_directory !cfg_dir);

  let cwd = Sys.getcwd () in

  let { opt; alive_tv } = lookup_dependencies cwd in
  opt_bin := opt;
  alive_tv_bin := alive_tv;

  let { out; crash; corpus; covers; muts } = setup_output cwd !out_dir in
  out_dir := out;
  crash_dir := crash;
  corpus_dir := corpus;
  covers_dir := covers;
  muts_dir := muts;

  if !dry_run then L.from_file "fuzz.log"
  else L.from_file (Filename.concat !out_dir "fuzz.log");

  L.set_level !log_level;
  log_options opts;

  if Sys.file_exists !seed_dir |> not then
    failwith ("Seed directory not found: " ^ !seed_dir);

  (* okay to pass this check if it is a dry-run*)
  Interests.set_interesting_types llctx
