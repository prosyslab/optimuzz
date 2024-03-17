type t
(** represents a path in the AST branch tree *)

val compare : t -> t -> int
val parse : string -> t option
val length : t -> int
val distance : t -> t -> int
val distances : t -> t -> (t * int) list
