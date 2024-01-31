open Util.ALlvm

(* a seed pool is a queue of (seed, covered, score) *)
type elt = llmodule * bool * int
type t = elt Queue.t

val make : llcontext -> unit LLModuleSet.t -> t
val pop : t -> elt * t
val push : elt -> t -> t
val cardinal : t -> int
