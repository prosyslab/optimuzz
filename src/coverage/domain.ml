module type COV_PER_FILE = sig
  type elt (* atom (e.g., line number) *)
  type t (* per-file (e.g., set of lines) *)

  val empty : t
  val add : elt -> t -> t
  val union : t -> t -> t
  val subset : t -> t -> bool
  val map : (elt -> elt) -> t -> t
  val cardinal : t -> int
end

module CovMap (CovPerFile : COV_PER_FILE) = struct
  module FNameMap = Map.Make (String)

  type t = CovPerFile.t FNameMap.t

  let empty : t = FNameMap.empty
  let add : string -> CovPerFile.t -> t -> t = FNameMap.add

  (** [join x y] adds all coverage in [y] into [x]. *)
  let join =
    FNameMap.merge (fun _ d_x d_y ->
        match (d_x, d_y) with
        | Some d_x, Some d_y -> Some (CovPerFile.union d_x d_y)
        | Some d, None | None, Some d -> Some d
        | None, None -> None)

  (** [subset x y] returns whether [x] is a sub-coverage of [y]. *)
  let subset x y =
    FNameMap.for_all
      (fun k d_x ->
        match FNameMap.find_opt k y with
        | Some d_y -> CovPerFile.subset d_x d_y
        | None -> false)
      x

  (** [cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let cardinal x =
    FNameMap.fold (fun _ d accu -> accu + CovPerFile.cardinal d) x 0
end

(* Simple line-based coverage*)
module LineSet = Set.Make (Int)
module LineCoverage = CovMap (LineSet)

(* string-tagged line coverage *)
module SLSet = Set.Make (struct
  type t = string * int

  let compare = compare
end)

module SL_Coverage = CovMap (SLSet)
