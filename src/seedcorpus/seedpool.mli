open Util.ALlvm

(* a seed pool is a queue of (seed, covered, score) *)
type seed_t = { llm : llmodule; covers : bool; score : float }
type t = seed_t Queue.t

val pp_seed : Format.formatter -> seed_t -> unit
val make : llcontext -> unit LLModuleSet.t -> t
val pop : t -> seed_t * t
val push : seed_t -> t -> t
val push_seq : seed_t Seq.t -> t -> t
val cardinal : t -> int
