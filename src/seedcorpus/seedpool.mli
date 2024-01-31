open Util.ALlvm

(* a seed pool is a queue of (seed, covered, score) *)
type seed_t = llmodule * bool * int
type t = seed_t Queue.t

val make : llcontext -> unit LLModuleSet.t -> t
val pop : t -> seed_t * t
val push : seed_t -> t -> t
val push_seq : seed_t Seq.t -> t -> t
val cardinal : t -> int
