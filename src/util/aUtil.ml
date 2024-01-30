let cmd args = args |> String.concat " " |> Sys.command

(* for logging *)
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp
let log_path = "fuzzing.log"
let log_formatter = log_path |> open_out |> Format.formatter_of_out_channel

let get_current_time () =
  let tm = Unix.gettimeofday () |> Unix.localtime in
  let year = tm.tm_year + 1900 in
  let month = tm.tm_mon + 1 in
  let day = tm.tm_mday in
  let hour = tm.tm_hour in
  let min = tm.tm_min in
  let sec = tm.tm_sec in
  Format.sprintf "%d%02d%02d%02d%02d%02d" year month day hour min sec

let now () = Unix.time () |> int_of_float

let name_opted_ver filename =
  if String.ends_with ~suffix:".ll" filename then
    String.sub filename 0 (String.length filename - 3) ^ ".opt.ll"
  else filename ^ ".opt.ll"

(** [rand_bool ()] returns true or false with probability 0.5 each. *)
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

(** [choose_random l] returns a random element from a list [l].
    @raise Invalid_argument if [l] is empty. *)
let choose_random = function
  | [] -> invalid_arg "Empty list"
  | l -> List.nth l (Random.int (List.length l))

(** [choose_arr a] returns a random element from an array [a].
    @raise Invalid_argument if [a] is empty. *)
let choose_arr a =
  let len = Array.length a in
  if len == 0 then invalid_arg "Empty array" else Array.get a (Random.int len)

let readlines filename =
  let file = open_in filename in
  let rec loop accu =
    match input_line file with
    | exception End_of_file -> accu
    | line -> loop (line :: accu)
  in
  let lines = loop [] |> List.rev in
  close_in file;
  lines

let clean filename =
  cmd [ "rm"; filename; "> /dev/null"; "2> /dev/null" ] |> ignore

let log fstr = Format.fprintf log_formatter fstr
