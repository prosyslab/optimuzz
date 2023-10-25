(* llfuzz directory which includes src/, README.md, etc. Automatically set. *)
let project_home = ref ""

(* paths *)
let pattern_path = ref ""
let cov_tgt_path = ref ""
let seed_dir = ref "seed"
let out_dir = ref "llfuzz-out"
let crash_dir = ref "crash"
let corpus_dir = ref "corpus"

(* build/binaries *)
let opt_bin = ref "llvm-project/build/bin/opt"
let alive2_bin = ref "alive2/build/alive-tv"

(* fuzzing options *)
let random_seed = ref 0
let time_budget = ref (-1)
let num_mutation = ref 1
let num_mutant = ref 10
let no_tv = ref true

(* logging options *)
let log_time = ref 30

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
    (* fuzzing options *)
    ("-random-seed", Arg.Set_int random_seed, "Set random seed");
    ("-limit", Arg.Set_int time_budget, "Time budget (limit in seconds)");
    ("-n-mutation", Arg.Set_int num_mutation, "Each mutant is mutated m times.");
    ("-n-mutant", Arg.Set_int num_mutant, "Each seed is mutated into n mutants.");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
    (* logging options *)
    ("-log-time", Arg.Set_int log_time, "Change timestamp interval");
  ]
