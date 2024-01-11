module Llset = Set.Make (struct
  type t = Sha256.t

  let compare sha1 sha2 = compare (Sha256.to_hex sha1) (Sha256.to_hex sha2)
end)

let llset = ref Llset.empty
let ( >> ) x f = f x |> ignore
let command_args args = args |> String.concat " " |> Sys.command

(* for logging *)
let alive2_log = "alive-tv.txt"
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp

let get_current_time () =
  let tm = Unix.gettimeofday () |> Unix.localtime in
  string_of_int (tm.tm_year + 1900)
  ^ string_of_int (tm.tm_mon + 1)
  ^ string_of_int tm.tm_mday ^ string_of_int tm.tm_hour
  ^ string_of_int tm.tm_min ^ string_of_int tm.tm_sec

let now () = Unix.time () |> int_of_float
let count = ref 0

let save_hash llm =
  let hash = Sha256.string llm in
  llset := Llset.add hash !llset

let get_new_name llm =
  let hash = Sha256.string llm in
  match Llset.find_opt hash !llset with
  | Some _ -> ""
  | None -> get_current_time () ^ "_" ^ Sha256.to_hex hash ^ ".ll"

let name_opted_ver filename =
  if String.ends_with ~suffix:".ll" filename then
    String.sub filename 0 (String.length filename - 3) ^ ".opt.ll"
  else filename ^ ".opt.ll"

(** [rand_bool () ] returns true or false with probability 0.5 each. *)
let rand_bool _ = Random.bool ()

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

let interesting_integers =
  [ 0; 1; 2; 255 (*0xFF*); 65535 (*0xFFFF*); 4294967295 (* 0xFFFFFFFF *) ]

(* let interesting_types = [ 1; 8; 10; 32; 34; 64; 128 ] *)
let interesting_types = [ 1; 8; 10; 32; 34; 64 ]

(** [choose_random l] returns a random element from a list [l].
    @raise Invalid_argument if [l] is empty. *)
let choose_random = function
  | [] -> raise (Invalid_argument "Empty list")
  | l -> List.nth l (Random.int (List.length l))
