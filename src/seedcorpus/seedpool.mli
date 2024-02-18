open Util

(* a seed pool is a queue of (seed, covered, score) *)
type seed_t = { llm : ALlvm.llmodule; covers : bool; score : float }
type t = seed_t AUtil.PrioQueue.queue

val pp_seed : Format.formatter -> seed_t -> unit
val make : ALlvm.llcontext -> unit ALlvm.LLModuleSet.t -> t
val pop : t -> seed_t * t
val push : seed_t -> t -> t
val push_list : seed_t List.t -> t -> t
val cardinal : t -> int
