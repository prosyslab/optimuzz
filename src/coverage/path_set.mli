type elt
(** represents a path in the AST branch tree *)

type t
(** collection of paths **)

val compare : elt -> elt -> int
val parse : string -> elt option
val length : elt -> int
val distance : elt -> elt -> int
val distances : elt -> elt -> (elt * int) list
val read : string -> t
val empty : t
val cardinal : t -> int
val union : t -> t -> t
val cover_target : elt -> t -> bool
