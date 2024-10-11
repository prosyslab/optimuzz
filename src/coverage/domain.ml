open Util
module L = Logger
module F = Format

(** represents a path in the AST branch tree *)
module Path : sig
  type t

  val compare : t -> t -> int
  val parse : string -> t option
  val length : t -> int
  val diff : t -> t -> int
  val distance : t -> t -> int
  val distances : t -> t -> (t * int) list
end = struct
  type t = string list
  (** represents a line in the coverage file *)

  let compare = compare

  (** parse coverage lines and return parsed string list
    example: InstCombineCompares.cpp:visitICmpInst:50:0 ->
    \["InstCombineCompares.cpp" ; "visitICmpInst"; "50"; "0"\]
  *)
  let parse s =
    let chunks = String.split_on_char ':' s |> List.filter (( <> ) "") in
    match chunks with
    | file :: func :: ids -> file :: func :: ids |> Option.some
    | _ -> None

  (** file and func also count as a length *)
  let length = List.length

  (* how many same nodes along the path from the root
     src : file1 ; func1 ; path1  ; path2  ; ...
     dst : file2 ; func2 ; path1' ; path2' ; ... *)
  let equal_depth src dst =
    let rec fold acc l1 l2 =
      match (l1, l2) with
      | hd1 :: tl1, hd2 :: tl2 when hd1 = hd2 -> fold (acc + 1) tl1 tl2
      | _ -> acc
    in

    fold 0 src dst

  (** [distance src dst] returns the distance of two nodes in a tree *)
  let distance src dst =
    let p = equal_depth src dst in
    length dst - p + (length src - p)

  (** [diff src dst] returns the number of changes required from [src] path to [dst] path.
      - [diff [A;B;C] [A;E;F] = 2].
      - [diff [A;B;C] [A;B;C;D]] = 1.
      - [diff [A;B;C] [A;B;C]] = 0.
      - [diff [A;B;C] [A;B;C;D;E]] = 2.
      *)
  let diff src dst = length dst - equal_depth src dst

  let distances src dst =
    src (* [A; B; C] *)
    |> List.rev (* [C; B; A] *)
    |> List.fold_left (* [ A ; A :: B ; A :: B :: C ] *)
         (fun accu p -> [ p ] :: List.map (fun a -> p :: a) accu)
         []
    |> List.fold_left (* [ (A, n1); (A :: B, n2); (A :: B :: C; n3) ] *)
         (fun accu p -> (p, distance p dst) :: accu)
         []
end

module DistanceSet = struct
  include Set.Make (struct
    type t = Path.t * int

    let compare = compare
  end)

  let sum_cnt s =
    (0, 0) |> fold (fun (_path, dist) (total, cnt) -> (total + dist, cnt + 1)) s
end

module AstCoverage = struct
  include Set.Make (Path)

  let read file =
    AUtil.readlines file |> List.filter_map Path.parse |> List.to_seq |> of_seq

  let of_lines lines =
    lines |> List.filter_map Path.parse |> List.to_seq |> of_seq

  let cover_target = mem
end

module type Distance = sig
  type t

  val distance : Path.t -> AstCoverage.t -> t
  val pp : Format.formatter -> t -> unit
  val compare : t -> t -> int
  val to_int : t -> int
  val to_priority : t -> int
  val of_string : string -> t
  val of_int : int -> t
end

module AverageDistance : Distance with type t = float = struct
  type t = float

  let distance target cov =
    let distances : DistanceSet.t =
      AstCoverage.fold
        (fun path accu ->
          let ds = Path.distances path target |> List.to_seq in
          accu |> DistanceSet.add_seq ds)
        cov DistanceSet.empty
    in
    let total, cnt = DistanceSet.sum_cnt distances in
    if cnt = 0 then !Config.max_distance |> float_of_int
    else
      let avg = float_of_int total /. float_of_int cnt in
      avg

  let pp fmt d = Format.fprintf fmt "%.3f" d
  let compare = Float.compare
  let to_priority dist = dist *. 10.0 |> int_of_float
  let of_string = float_of_string
  let to_int = int_of_float
  let of_int = float_of_int
end

module MinDistance : Distance with type t = int = struct
  type t = int

  let distance target cov =
    let module IntSet = Set.Make (Int) in
    let distances =
      AstCoverage.fold
        (fun path accu ->
          let d = Path.diff path target in
          accu |> IntSet.add d)
        cov IntSet.empty
    in
    try IntSet.min_elt distances with Not_found -> !Config.max_distance

  let pp fmt d = Format.fprintf fmt "%d" d
  let compare = Int.compare
  let to_priority dist = dist * 10
  let of_string = int_of_string
  let to_int = Fun.id
  let of_int = Fun.id
end

(** used for edge coverage based (naive greybox) fuzzing *)
module PCGuardEdgeCoverage = struct
  include Set.Make (Int)

  let read file = AUtil.readlines file |> List.map int_of_string |> of_list
  let of_lines lines = List.map int_of_string lines |> of_list
end

module IntInt = struct
  type t = int * int

  let compare = compare
  let equal = ( = )
  let hash = Hashtbl.hash
end

let parse_targets targets_file =
  AUtil.readlines targets_file
  |> List.map (fun line ->
         let chunks = String.split_on_char ':' line in
         let filename = List.nth chunks 0 |> Filename.basename in
         let lineno = List.nth chunks 1 |> int_of_string in
         (filename, lineno))
  |> List.sort_uniq compare

let load_cfgs_from_dir cfg_dir =
  Sys.readdir cfg_dir
  |> Array.to_list
  |> List.map (fun filename -> Filename.concat cfg_dir filename)
  |> List.filter (fun filename -> Filename.check_suffix filename ".dot")
  |> List.filter_map Aflgo.ControlFlowGraph.of_dot_file

module BlockTrace = struct
  type t = int list

  let of_lines lines =
    (* SAFETY: if the file is generated, it has at least one line *)
    let lines =
      lines
      |> List.map (fun line ->
             match int_of_string_opt line with
             | Some n -> n
             | None ->
                 F.eprintf "BlockTrace.of_lines: invalid line %s" line;
                 exit 1)
    in
    match lines with
    | [] -> []
    | _ ->
        let entrypoint = List.hd lines in
        let rec aux accu = function
          | [] -> accu |> List.map List.rev
          | hd :: tl when hd = entrypoint -> aux ([ hd ] :: accu) tl
          | hd :: tl -> (
              match accu with
              | curr :: rest -> aux ((hd :: curr) :: rest) tl
              | _ -> failwith "unreachable")
        in

        (* [A;B;C;D;A;B;C] -> [[A;B;C;D]; [A;B;C]] *)
        aux [] lines

  (** Returns a list of traces. Note that a single coverage file (cov.cov)
     can contains many traces *)
  let read file =
    let lines = AUtil.readlines file in
    of_lines lines

  let empty = []
  let union = List.append
  let diff _ _ = failwith "unneceesary"
  let cardinal = List.length
end

module EdgeCoverage = struct
  include Set.Make (IntInt)

  let of_traces traces =
    traces
    |> List.map AUtil.pairs
    |> List.map of_list
    |> List.fold_left union empty

  let read file =
    let open AUtil in
    let traces = BlockTrace.read file in
    traces |> List.map pairs |> List.map of_list |> List.fold_left union empty

  let pp covset = iter (fun (i1, i2) -> L.debug "%d %d\n" i1 i2) covset
end

let sliced_cfg_node_of_addr node_tbl distmap addr =
  match Aflgo.NodeTable.find_opt node_tbl addr with
  | None -> None (* in CFG of a function other than the target function *)
  | Some node ->
      if Aflgo.DistanceTable.mem node distmap then Some node else None

module CfgDistance = struct
  type t = float

  (** computes distance of a trace *)
  let distance_score (traces : BlockTrace.t list) node_tbl distmap =
    let nodes_in_trace =
      traces
      |> List.flatten
      |> List.sort_uniq compare
      |> List.filter_map (sliced_cfg_node_of_addr node_tbl distmap)
    in
    let dist_sum : float =
      nodes_in_trace
      |> List.fold_left
           (fun sum node ->
             let dist = Aflgo.DistanceTable.find_opt node distmap in
             match dist with None -> sum | Some dist -> sum +. dist)
           0.0
    in
    (* let min_dist =
         nodes_in_trace
         |> List.filter_map (fun node -> Cfg.NodeMap.find_opt node distmap)
         |> List.fold_left (fun accu dist -> Float.min accu dist) 65535.0
       in *)
    if nodes_in_trace = [] then 65535.0
    else
      let size = List.length nodes_in_trace |> float_of_int in
      dist_sum /. size

  let get_cover (traces : BlockTrace.t list) node_tbl distmap =
    traces
    |> List.exists
         (List.exists (fun addr ->
              let node = Aflgo.NodeTable.find_opt node_tbl addr in
              match node with
              | None -> false
              | Some node ->
                  Aflgo.DistanceTable.find_opt node distmap = Some 0.0))
end

module type COVERAGE = sig
  type t

  val read : string -> t
  val empty : t
  val union : t -> t -> t
  val diff : t -> t -> t
  val cardinal : t -> int
end

module type PROGRESS = sig
  module Coverage : COVERAGE

  type t = { cov_sofar : Coverage.t; gen_count : int }

  val empty : t
  val inc_gen : t -> t
  val add_cov : Coverage.t -> t -> t
  val pp : Format.formatter -> t -> unit
end

module Progress (Coverage : COVERAGE) :
  PROGRESS with module Coverage = Coverage = struct
  module Coverage = Coverage

  type t = { cov_sofar : Coverage.t; gen_count : int }

  let empty = { cov_sofar = Coverage.empty; gen_count = 0 }
  let inc_gen p = { p with gen_count = p.gen_count + 1 }
  let add_cov cov p = { p with cov_sofar = Coverage.union p.cov_sofar cov }

  let pp fmt progress =
    F.fprintf fmt "generated: %d, coverage: %d" progress.gen_count
      (Coverage.cardinal progress.cov_sofar)
end
