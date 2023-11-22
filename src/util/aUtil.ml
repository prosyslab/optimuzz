let ( >> ) x f = f x |> ignore
let command_args args = args |> String.concat " " |> Sys.command

(* for logging *)
let alive2_log = "alive-tv.txt"
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp
let now () = Unix.time () |> int_of_float
let count = ref 0

let get_new_name () =
  count := !count + 1;
  string_of_int !count ^ ".ll"

let name_opted_ver filename =
  if String.ends_with ~suffix:".ll" filename then
    String.sub filename 0 (String.length filename - 3) ^ ".opt.ll"
  else filename ^ ".opt.ll"

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

let interesting_integers = [ 0; 1; 2; 4294967295 (* 0xFFFFFFFF *) ]

let list_random l =
  if l <> [] then List.nth l (Random.int (List.length l))
  else raise (Invalid_argument "Empty list")
