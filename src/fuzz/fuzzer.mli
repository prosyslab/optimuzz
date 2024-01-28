open Util.ALlvm
open Seedcorpus
open Coverage.Domain

val run : Seedpool.t -> llcontext -> DistanceSet.t -> int -> DistanceSet.t
