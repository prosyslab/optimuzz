module CD = Coverage.Domain
open Util

module type SEED_PRINTER = sig
  type t

  val pp : Format.formatter -> t -> unit
  val name : ?parent:int -> t -> string
end

module type SEED_MEASURE = sig
  type t

  module Distance : CD.Distance

  val score : t -> Distance.t
  val covers : t -> bool
  val closer : t -> t -> bool
end

module type NAIVE_SEED = sig
  type t

  include SEED_PRINTER with type t := t

  val make : Llvm.llmodule -> t
  val llmodule : t -> Llvm.llmodule
end

module type SEED = sig
  module Distance : CD.Distance

  type t

  include SEED_PRINTER with type t := t
  include SEED_MEASURE with type t := t with module Distance := Distance

  val make : Llvm.llmodule -> CD.Path.t -> CD.AstCoverage.t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
end

module type PRIORITY_SEED = sig
  module Distance : CD.Distance

  type t

  include SEED_PRINTER with type t := t
  include SEED_MEASURE with type t := t with module Distance := Distance

  val make : Llvm.llmodule -> CD.Path.t -> CD.AstCoverage.t -> t
  val priority : t -> int
  val inc_priority : t -> t
  val llmodule : t -> Llvm.llmodule
  val overwrite : t -> Llvm.llmodule -> t
end

module type QUEUE = sig
  type elt
  type t

  val empty : t

  val register : elt -> t -> t
  (** push a seed to the queue for the first time *)

  val push : elt -> t -> t
  (** push a seed to the queue -- not the first time *)

  val pop : t -> elt * t
  val length : t -> int
  val iter : (elt -> unit) -> t -> unit
end

module type SEED_POOL = sig
  module Seed : SEED
  include QUEUE with type elt = Seed.t

  val make : Llvm.llcontext -> CD.Path.t -> t
end

module type UNDIRECTED_SEED_POOL = sig
  module Seed : NAIVE_SEED
  include QUEUE with type elt = Seed.t

  val make : Llvm.llcontext -> t
end

module DistancedSeed (Distance : CD.Distance) = struct
  module Distance = Distance

  type t = { llm : Llvm.llmodule; score : Distance.t; covers : bool }

  let make llm target_path cov =
    let covers = CD.AstCoverage.cover_target target_path cov in
    let score = Distance.distance target_path cov in
    { llm; covers; score }

  let llmodule seed = seed.llm
  let covers seed = seed.covers
  let score seed = seed.score
  let overwrite seed llm = { seed with llm }

  let pp fmt seed =
    Format.fprintf fmt "hash: %010d, score: %a, covers: %b"
      (ALlvm.hash_llm seed.llm) Distance.pp seed.score seed.covers

  let name ?(parent : int option) seed =
    let hash = ALlvm.hash_llm seed.llm in
    let curr = AUtil.get_current_time () in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d,score:%a,covers:%b.ll" curr hash
          Distance.pp seed.score seed.covers
    | Some parent_hash ->
        Format.asprintf "date:%s,id:%010d,src:%010d,score:%a,covers:%b.ll" curr
          hash parent_hash Distance.pp seed.score seed.covers

  let closer old_seed new_seed =
    new_seed.covers || ((not old_seed.covers) && new_seed.score < old_seed.score)
end

module PriorityDistancedSeed (Dist : CD.Distance) = struct
  module Distance = Dist
  module Seed = DistancedSeed (Dist)

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

(** Seed configuration unaware of directed fuzzing.
    It does not contain (covers, score) which is used for guiding input generation *)
module NaiveSeed = struct
  type t = Llvm.llmodule

  let make llm = llm
  let llmodule seed = seed
  let pp fmt seed = Format.fprintf fmt "hash: %10d" (ALlvm.hash_llm seed)

  let name ?(parent : int option) seed =
    let hash = ALlvm.hash_llm seed in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d.ll" (AUtil.get_current_time ()) hash
    | Some parent_hash ->
        Format.asprintf "date:%s,id:%010d,src:%010d.ll"
          (AUtil.get_current_time ())
          hash parent_hash
end
