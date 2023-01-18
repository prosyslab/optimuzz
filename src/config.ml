let project_home = ref ""
let out_dir = ref "llfuzz-out"
let seed_dir = ref "seed"
let alive2_bin = ref ""
let opts = [ ("-out_dir", Arg.Set_string out_dir, "Output directory") ]
