(* each coverage is represented by id *)
module Id = Int

(* set of id *)
module IdSet = Set.Make (Id)

(* map from (file)name to set of coverage *)
module CovMap = struct
  module NameMap = Map.Make (String)

  type t = IdSet.t NameMap.t

  let empty : t = NameMap.empty
  let add : string -> IdSet.t -> t -> t = NameMap.add
  let mem : string -> t -> bool = NameMap.mem
  let find : string -> t -> IdSet.t = NameMap.find

  let update : string -> (IdSet.t option -> IdSet.t option) -> t -> t =
    NameMap.update

  (** [join x y] adds all coverage in [y] into [x]. *)
  let join =
    NameMap.merge (fun _ d_x d_y ->
        match (d_x, d_y) with
        | Some d_x, Some d_y -> Some (IdSet.union d_x d_y)
        | Some d, None | None, Some d -> Some d
        | None, None -> None)

  (** [subset x y] returns whether [x] is a sub-coverage of [y]. *)
  let subset x y =
    NameMap.for_all
      (fun k d_x ->
        match NameMap.find_opt k y with
        | Some d_y -> IdSet.subset d_x d_y
        | None -> false)
      x

  (** [cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let cardinal x = NameMap.fold (fun _ d accu -> accu + IdSet.cardinal d) x 0
end
