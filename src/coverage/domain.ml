(* location of each coverage groups, i.e., file name and function name *)
module Loc = struct
  type t = string * string

  let compare = compare
end

(* each coverage is represented by coverage id *)
module Id = Int

(* set of distances from the target node *)
module DistanceSet = struct
  include Set.Make (Int)

  let avg_elt set =
    if cardinal set = 0 then raise Not_found
    else
      let total = fold (fun total i -> total + i) set 0 in
      total / cardinal set

  let metric =
    match !Config.metric with
    | "min" -> min_elt
    | "max" -> max_elt
    | "avg" -> avg_elt
    | _ ->
        Format.sprintf "invalid metric configuration: %s@." !Config.metric
        |> invalid_arg

  let cover_target set = mem 0 set
end

(* map from location to group  *)
module CovMap = struct
  module LocMap = Map.Make (Loc)

  type t = DistanceSet.t LocMap.t

  let empty : t = LocMap.empty
  let add : Loc.t -> DistanceSet.t -> t -> t = LocMap.add

  let mem loc id cov_map =
    match LocMap.find_opt loc cov_map with
    | Some group -> DistanceSet.mem id group
    | None -> false

  let update : Loc.t -> (DistanceSet.t option -> DistanceSet.t option) -> t -> t
      =
    LocMap.update

  (** [join x y] adds all coverage in [y] into [x]. *)
  let join =
    LocMap.merge (fun _ d_x d_y ->
        match (d_x, d_y) with
        | Some d_x, Some d_y -> Some (DistanceSet.union d_x d_y)
        | Some d, None | None, Some d -> Some d
        | None, None -> None)

  (** [subset x y] returns whether [x] is a sub-coverage of [y]. *)
  let subset x y =
    LocMap.for_all
      (fun k d_x ->
        match LocMap.find_opt k y with
        | Some d_y -> DistanceSet.subset d_x d_y
        | None -> false)
      x

  (** [cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let cardinal x =
    LocMap.fold (fun _ d accu -> accu + DistanceSet.cardinal d) x 0
end
