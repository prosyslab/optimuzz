let project_home = ref ""
let out_dir = ref "llfuzz-out"
let seed_dir = ref "seed"
let alive2_bin = ref "alive2/build/alive-tv"
let bin = ref "llvm-project/build/bin/llc"
let gcno = ref "llvm-project/build/tools/llc/CMakeFiles/llc.dir/llc.cpp.gcno"
let gcda = ref "llvm-project/build/tools/llc/CMakeFiles/llc.dir/llc.cpp.gcda"
let gcov = ref "llc.cpp.gcov"
let no_tv = ref false

let opts =
  [
    ("-out-dir", Arg.Set_string out_dir, "Output directory");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
  ]
