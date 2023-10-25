(* location of each coverage groups, i.e., file name and function name *)
module Loc = struct
  type t = string * string

  let compare = compare
end

(* each coverage is represented by coverage id *)
module Id = Int

(* set of id *)
module Group = Set.Make (Id)

(* map from location to group  *)
module CovMap = struct
  module LocMap = Map.Make (Loc)

  type t = Group.t LocMap.t

  let empty : t = LocMap.empty
  let add : Loc.t -> Group.t -> t -> t = LocMap.add

  let mem loc id cov_map =
    match LocMap.find_opt loc cov_map with
    | Some group -> Group.mem id group
    | None -> false

  let update : Loc.t -> (Group.t option -> Group.t option) -> t -> t =
    LocMap.update

  (** [join x y] adds all coverage in [y] into [x]. *)
  let join =
    LocMap.merge (fun _ d_x d_y ->
        match (d_x, d_y) with
        | Some d_x, Some d_y -> Some (Group.union d_x d_y)
        | Some d, None | None, Some d -> Some d
        | None, None -> None)

  (** [subset x y] returns whether [x] is a sub-coverage of [y]. *)
  let subset x y =
    LocMap.for_all
      (fun k d_x ->
        match LocMap.find_opt k y with
        | Some d_y -> Group.subset d_x d_y
        | None -> false)
      x

  (** [cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let cardinal x = LocMap.fold (fun _ d accu -> accu + Group.cardinal d) x 0
end
