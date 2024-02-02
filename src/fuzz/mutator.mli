open Util.ALlvm

type mode_t = EXPAND | FOCUS
type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE

val run : llcontext -> Seedcorpus.Seedpool.seed_t -> llmodule
