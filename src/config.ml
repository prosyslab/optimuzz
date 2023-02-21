let project_home = ref ""
let out_dir = ref "llfuzz-out"
let seed_dir = ref "seed"
let alive2_bin = ref "alive2/build/alive-tv"
let bin = ref "llvm-project/build/bin/opt"
let no_tv = ref false
let mutate_times = ref 5
let fuzzing_times = ref 5
let alive2_log = ref "alive-tv.txt"
let crash_log = ref "crashes.txt"
let log_time = ref 30.0

(* whitelist
   refer to: https://llvm.org/docs/Passes.html *)
let _instCombine = ref true

let opts =
  [
    ("-out-dir", Arg.Set_string out_dir, "Output directory");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
    ("-mut-time", Arg.Set_int mutate_times, "Change mutation times");
    ("-fuz-time", Arg.Set_int fuzzing_times, "Change fuzzing times");
    ("-crash-log", Arg.Set_string crash_log, "Output of crashed mutations");
    ( "-log-time",
      Arg.Set_float log_time,
      "Change time interval for creating logs" );
    (* whitelist *)
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
