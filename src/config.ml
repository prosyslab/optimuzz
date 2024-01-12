(* llfuzz directory which includes src/, README.md, etc. Automatically set. *)
let project_home = ref ""

(* paths *)
let pattern_path = ref ""
let cov_tgt_path = ref ""
let seed_dir = ref "seed"
let out_dir = ref "llfuzz-out"
let crash_dir = ref "crash"
let corpus_dir = ref "corpus"
let gcov_dir = ref "gcov"
let workspace = ref ""

(* build/binaries *)
(* let opt_bin = ref "llvm-project/build/bin/opt" *)
let opt_bin = ref "./opt"
let alive_tv_bin = ref "Alive2/alive2/build/alive-tv"

(* seed options *)
let max_initial_seed = ref 100
let random_seed = ref 0
let max_distance = ref 65536

(* fuzzing options *)
let time_budget = ref (-1)
let cov_directed = ref ""
let num_mutation = ref 10
let num_mutant = ref 1
let no_tv = ref false

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
    (* fuzzing options *)
    ("-random-seed", Arg.Set_int random_seed, "Set random seed");
    ("-limit", Arg.Set_int time_budget, "Time budget (limit in seconds)");
    ("-direct", Arg.Set_string cov_directed, "Target coverage id");
    ("-n-mutation", Arg.Set_int num_mutation, "Each mutant is mutated m times.");
    ("-n-mutant", Arg.Set_int num_mutant, "Each seed is mutated into n mutants.");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
    (* logging options *)
    ("-log-time", Arg.Set_int log_time, "Change timestamp interval");
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
