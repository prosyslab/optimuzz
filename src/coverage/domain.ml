module type COVERAGE = sig
  type t

  val empty : t
  val cardinal : t -> int
  val union : t -> t -> t
  val read : string -> t
  val score : Path.t -> t -> float option
  val cover_target : Path.t -> t -> bool
end
