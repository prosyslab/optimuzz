let ( >> ) x f = f x |> ignore
let command_args args = args |> String.concat " " |> Sys.command

(** [rand low high] returns a random integer
    between [low] and [high] (both inclusive). *)
let rand low high = Random.int (high - low + 1) + low

(** [repeat_fun f init t] is [f (... (f (f init)) ...)] ([t] times).
    @raise Invalid_argument if [t] is negative. *)
let repeat_fun f init t =
  if t < 0 then raise (Invalid_argument "Negative t")
  else
    let rec aux accu count =
      if count = 0 then accu else aux (f accu) (count - 1)
    in
    aux init t

(** [list_random l] returns a random element from a list [l].
    @raise Invalid_argument if [l] is empty. *)
let list_random l =
  if l <> [] then List.nth l (Random.int (List.length l))
  else raise (Invalid_argument "Empty list")
