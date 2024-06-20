module CD = Coverage.Domain
open Util

module type SEED = sig
  module Distance : CD.Distance

  type t

  val make : Llvm.llmodule -> CD.Path.t -> CD.Coverage.t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
  val covers : t -> bool
  val score : t -> Distance.t
  val name : ?parent:int -> t -> string
  val pp : Format.formatter -> t -> unit
  val closer : t -> t -> bool
end

module type PRIORITY_SEED = sig
  module Distance : CD.Distance

  type t

  val make : Llvm.llmodule -> CD.Path.t -> CD.Coverage.t -> t
  val priority : t -> int
  val inc_priority : t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
  val covers : t -> bool
  val score : t -> Distance.t
  val name : ?parent:int -> t -> string
  val pp : Format.formatter -> t -> unit
  val closer : t -> t -> bool
end

module type QUEUE = sig
  type elt
  type t

  val empty : t

  val register : elt -> t -> t
  (** push a seed to the queue for the first time *)

  val push : elt -> t -> t
  (** push a seed to the queue -- not the first time *)

  val push_if_closer : elt -> elt -> t -> t
  val pop : t -> elt * t
  val length : t -> int
  val iter : (elt -> unit) -> t -> unit
end

module type SEED_POOL = sig
  module Seed : SEED
  include QUEUE with type elt = Seed.t

  val make : Llvm.llcontext -> CD.Path.t -> t
end

module Seed (Distance : CD.Distance) = struct
  module Distance = Distance

  type t = { llm : Llvm.llmodule; score : Distance.t; covers : bool }

  let make llm target_path cov =
    let covers = CD.Coverage.cover_target target_path cov in
    let score = Distance.distance target_path cov in
    { llm; covers; score }

  let llmodule seed = seed.llm
  let covers seed = seed.covers
  let score seed = seed.score
  let overwrite seed llm = { seed with llm }

  let pp fmt seed =
    Format.fprintf fmt "hash: %10d, score: %a, covers: %b"
      (ALlvm.hash_llm seed.llm) Distance.pp seed.score seed.covers

  let name ?(parent : int option) seed =
    let hash = ALlvm.hash_llm seed.llm in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d,score:%a,covers:%b.ll"
          (AUtil.get_current_time ())
          hash Distance.pp seed.score seed.covers
    | Some parent_hash ->
        Format.asprintf "date:%s,id:%010d,src:%010d,score:%a,covers:%b.ll"
          (AUtil.get_current_time ())
          hash parent_hash Distance.pp seed.score seed.covers

  let closer old_seed new_seed =
    new_seed.covers || ((not old_seed.covers) && new_seed.score < old_seed.score)
end

module PrioritySeed (Dist : CD.Distance) = struct
  module Distance = Dist
  module Seed = Seed (Dist)

  type t = int * Seed.t

  let make llm target_path cov =
    let seed = Seed.make llm target_path cov in
    (Seed.score seed |> Seed.Distance.to_priority, seed)

  let priority seed = fst seed
  let inc_priority seed = (fst seed + 1, snd seed)
  let llmodule seed = snd seed |> Seed.llmodule
  let covers seed = Seed.covers (snd seed)
  let score (seed : t) = Seed.score (snd seed)
  let overwrite seed llm = (fst seed, Seed.overwrite (snd seed) llm)
  let pp fmt seed = Seed.pp fmt (snd seed)
  let name ?parent seed = Seed.name ?parent (snd seed)
  let closer old_seed new_seed = Seed.closer (snd old_seed) (snd new_seed)
end
