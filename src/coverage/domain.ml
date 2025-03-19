open Util
module L = Logger
module F = Format

let parse_targets targets_file =
  (AUtil.readlines targets_file
  |> List.map (fun line ->
         let chunks = String.split_on_char ':' line in
         let filename = List.nth chunks 0 |> Filename.basename in
         let lineno = List.nth chunks 1 |> int_of_string in
         (filename, lineno))
  |> List.sort_uniq compare
  |> List.hd)
  :: []

let load_cfgs_from_dir cfg_dir =
  Sys.readdir cfg_dir
  |> Array.to_list
  |> List.map (fun filename -> Filename.concat cfg_dir filename)
  |> List.filter (fun filename -> Filename.check_suffix filename ".dot")
  |> List.filter_map Icfg.ControlFlowGraph.of_dot_file

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

module IntInt = struct
  type t = int * int

  let compare = compare
  let equal = ( = )
  let hash = Hashtbl.hash
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
  match Icfg.AddrToNode.find_opt node_tbl addr with
  | None -> None (* in CFG of a function other than the target function *)
  | Some node -> if Icfg.DistanceTable.mem node distmap then Some node else None

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
             let dist = Icfg.DistanceTable.find_opt node distmap in
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
              let node = Icfg.AddrToNode.find_opt node_tbl addr in
              match node with
              | None -> false
              | Some node -> Icfg.DistanceTable.find_opt node distmap = Some 0.0))
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
