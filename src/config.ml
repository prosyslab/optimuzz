let project_home = ref ""

(* directories *)
let seed_dir = ref "seed"
let out_dir = ref "llfuzz-out"
let crash_dir = ref "llfuzz-crash"

(* binary files and flags *)
let bin = ref "llvm-project/build/bin/opt"
let alive2_bin = ref "alive2/build/alive-tv"
let no_tv = ref false

(* fuzzing options *)
let seed = ref 0
let time_budget = ref (60 * 60 * 4)
let mutate_times = ref 1
let fuzzing_times = ref 10

(* logging options *)
let log_time = ref 30

(* whitelist
   refer to: https://llvm.org/docs/Passes.html *)
let _instCombine = ref true

let opts =
  [
    ("-out-dir", Arg.Set_string out_dir, "Output directory");
    ( "-crash-dir",
      Arg.Set_string crash_dir,
      "Output directory for crashing mutants" );
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
    ("-seed", Arg.Set_int seed, "Set random seed");
    ("-limit", Arg.Set_int time_budget, "Time budget (limit in seconds)");
    ("-mut-time", Arg.Set_int mutate_times, "Change mutation times");
    ("-fuz-time", Arg.Set_int fuzzing_times, "Change fuzzing times");
    ("-log-time", Arg.Set_int log_time, "Change timestamp interval");
    ( "-instcombine",
      Arg.Set _instCombine,
      "[register whitelist] Combine instructions to form fewer, simple \
       instructions" );
  ]

let to_gcda category code =
  "llvm-project/build/lib/Transforms/" ^ category ^ "/CMakeFiles/LLVM"
  ^ category ^ ".dir/" ^ code ^ ".cpp.gcda"

let to_gcov code = "./" ^ code ^ ".cpp.gcov"

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

let whitelist =
  lazy
    (optimizations
    |> List.filter (fun elem -> !(fst elem))
    |> List.map (fun elem -> snd elem))

let gcda_list =
  lazy
    (whitelist |> Lazy.force
    |> List.map (fun elem ->
           let category = fst elem in
           List.map (fun code -> to_gcda category code) (snd elem))
    |> List.concat)

let gcov_list =
  lazy
    (whitelist |> Lazy.force
    |> List.map (fun elem -> List.map to_gcov (snd elem))
    |> List.concat)
