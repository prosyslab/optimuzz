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

module Coverage (CovPerFile : COV_PER_FILE) = struct
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

  (** [subset x y] returns whether [x] is a total sub-coverage of [y]. *)
  let subset x =
    FNameMap.for_all (fun k d_y ->
        match FNameMap.find_opt k x with
        | Some d_x -> CovPerFile.subset d_x d_y
        | None -> false)

  (** [total_cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let total_cardinal x =
    FNameMap.fold (fun _ d accu -> accu + (d |> CovPerFile.cardinal)) x 0
end

(* Simple line-based coverage*)
module LineSet = Set.Make (Int)
module LineCoverage = Coverage (LineSet)

(* mutation-tagged line coverage *)

module MLSet = Set.Make (struct
  type t = string * int

  let compare = compare
end)

module ML_Coverage = Coverage (MLSet)
