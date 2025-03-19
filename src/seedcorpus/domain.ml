module CD = Coverage.Domain
open Util

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
