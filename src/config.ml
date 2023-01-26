let project_home = ref ""
let out_dir = ref "llfuzz-out"
let seed_dir = ref "seed"
let alive2_bin = ref "alive2/build/alive-tv"
let bin = ref "llvm-project/build/bin/opt"
let gcno = ref "llvm-project/build/tools/opt/CMakeFiles/opt.dir/opt.cpp.gcno"
let gcda = ref "llvm-project/build/tools/opt/CMakeFiles/opt.dir/opt.cpp.gcda"
let gcov = ref "opt.cpp.gcov"
let no_tv = ref false

let opts =
  [
    ("-out-dir", Arg.Set_string out_dir, "Output directory");
    ("-no-tv", Arg.Set no_tv, "Turn off translation validation");
  ]
