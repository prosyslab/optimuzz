let cmd args = args |> String.concat " " |> Sys.command

(* for logging *)
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp

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

let read_lines filename =
  let ic = open_in filename in
  let try_read () = try Some (input_line ic) with End_of_file -> None in
  let rec loop acc =
    match try_read () with
    | Some s -> loop (s :: acc)
    | None ->
        close_in ic;
        List.rev acc
  in
  loop []

let increase_numbers entry =
  let numbers =
    entry |> Yojson.Basic.Util.member "numbers" |> Yojson.Basic.Util.to_int
  in
  `Assoc
    [
      ("lines", entry |> Yojson.Basic.Util.member "lines");
      ("numbers", `Int (numbers + 1));
    ]

let update_numbers_with_cov filename cov =
  let json = Yojson.Basic.from_file filename in
  let json_assoc = json |> Yojson.Basic.Util.to_assoc in
  let updated_json =
    List.fold_left
      (fun acc (key, values) ->
        if List.mem key cov then
          let updated_values =
            values |> Yojson.Basic.Util.to_list |> List.map increase_numbers
          in
          (key, `List updated_values) :: acc
        else (key, values) :: acc)
      [] json_assoc
  in
  `Assoc updated_json |> Yojson.Basic.to_file filename

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

let arr_random_except arr exc =
  assert (Array.length arr > 1);
  let rec loop () =
    let ret = choose_arr arr in
    if ret = exc then loop () else ret
  in
  loop ()

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

module PrioQueue = struct
  type priority = int
  type 'a queue = Empty | Node of priority * 'a * 'a queue * 'a queue

  let empty = Empty

  let rec insert queue prio elt =
    match queue with
    | Empty -> Node (prio, elt, Empty, Empty)
    | Node (p, e, left, right) ->
        if prio < p then Node (prio, elt, insert right p e, left)
        else Node (p, e, insert right prio elt, left)

  exception Queue_is_empty

  let rec length = function
    | Empty -> 0
    | Node (_, _, left, Empty) -> 1 + length left
    | Node (_, _, Empty, right) -> 1 + length right
    | Node (_, _, (Node _ as left), (Node _ as right)) ->
        1 + length left + length right

  let rec remove_top = function
    | Empty -> raise Queue_is_empty
    | Node (_, _, left, Empty) -> left
    | Node (_, _, Empty, right) -> right
    | Node
        ( _,
          _,
          (Node (lprio, lelt, _, _) as left),
          (Node (rprio, relt, _, _) as right) ) ->
        if lprio < rprio then Node (lprio, lelt, remove_top left, right)
        else Node (rprio, relt, left, remove_top right)

  let extract = function
    | Empty -> raise Queue_is_empty
    | Node (_, elt, _, _) as queue -> (elt, remove_top queue)

  (** [iter f queue] applies [f] to all elements of [queue].
      Pre-order traversal. *)
  let rec iter f = function
    | Empty -> ()
    | Node (_, elt, left, right) ->
        f elt;
        iter f left;
        iter f right
end

let ( let+ ) = Result.bind
let ( let* ) = Option.bind

let filter_map_res f lst =
  List.filter_map (fun x -> f x |> Result.to_option) lst

(** [take n lst] returns the first [n] elements in [list] *)
let take n lst =
  let rec aux acc n = function
    | [] -> List.rev acc
    | _ when n = 0 -> List.rev acc
    | hd :: tl -> aux (hd :: acc) (n - 1) tl
  in
  aux [] n lst
