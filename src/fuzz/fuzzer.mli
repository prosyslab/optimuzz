open Util.ALlvm
open Seedcorpus
open Coverage.Domain

val run : Seedpool.t -> llcontext -> CovSet.t -> int -> CovSet.t
