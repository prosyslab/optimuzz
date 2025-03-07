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

(** Seed configuration only aware of llmodule data.
    It only contains llvm module data *)
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

module CfgSeed = struct
  module Distance = CD.CfgDistance

  type t = {
    llm : Llvm.llmodule;
    score : Distance.t;
    covers : bool;
    edge_cov : CD.EdgeCoverage.t;
    importants : string;
  }

  let make llm (traces : CD.BlockTrace.t list) importants node_tbl distmap =
    let score = Distance.distance_score traces node_tbl distmap in
    let covers = Distance.get_cover traces node_tbl distmap in
    {
      llm;
      score;
      covers;
      edge_cov = CD.EdgeCoverage.of_traces traces;
      importants;
    }

  let llmodule seed = seed.llm
  let covers seed = seed.covers
  let score seed = seed.score
  let edge_cov seed = seed.edge_cov

  let get_energy seed =
    if !Config.score = Config.FuzzingMode.Constant then 4
    else
      let int_score = Float.to_int seed.score in
      if seed.covers then 12 else if int_score >= 10 then 3 else 12 - int_score

  let name ?(parent : int option) seed =
    let hash = ALlvm.hash_llm seed.llm in
    match parent with
    | None ->
        Format.asprintf "date:%s,id:%010d,score:%f,covers:%b.ll"
          (AUtil.get_current_time ())
          hash seed.score seed.covers
    | Some parent_hash ->
        Format.asprintf "date:%s,id:%010d,src:%010d,score:%f,covers:%b.ll"
          (AUtil.get_current_time ())
          hash parent_hash seed.score seed.covers

  let pp fmt seed =
    Format.fprintf fmt "score: %f, covers: %b,@.%s" seed.score seed.covers
      (ALlvm.string_of_llmodule seed.llm)
end
