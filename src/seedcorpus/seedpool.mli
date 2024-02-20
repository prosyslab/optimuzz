open Util

(* a seed pool is a queue of (seed, covered, score) *)
type seed_t = {
  priority : int;
  llm : ALlvm.llmodule;
  covers : bool;
  score : float;
}

type t = seed_t AUtil.PrioQueue.queue

val pp_seed : Format.formatter -> seed_t -> unit
val make : ALlvm.llcontext -> unit ALlvm.LLModuleSet.t -> t
val get_prio : bool -> float -> int
val pop : t -> seed_t * t
val push : seed_t -> t -> t
val push_list : seed_t List.t -> t -> t
val cardinal : t -> int
val iter : (seed_t -> unit) -> t -> unit
