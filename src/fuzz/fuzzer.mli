open Util.ALlvm
open Seedcorpus
module CD = Coverage.Domain

val run : Seedpool.t -> llcontext -> CD.Coverage.t -> int -> CD.Coverage.t
