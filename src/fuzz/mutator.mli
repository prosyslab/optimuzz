open Util.ALlvm

type mode_t = EXPAND | FOCUS

val run : llcontext -> Seedcorpus.Seedpool.seed_t -> llmodule
