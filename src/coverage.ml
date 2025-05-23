open Util
module F = Format
module L = Logger

let parse_targets targets_file =
  AUtil.readlines targets_file
  |> List.map (fun line ->
         let chunks = String.split_on_char ':' line in
         let filename = List.nth chunks 0 |> Filename.basename in
         let lineno = List.nth chunks 1 |> int_of_string in
         (filename, lineno))
  |> List.sort_uniq compare

module BlockTrace = struct
  type t = int list

  let of_lines lines =
    (* SAFETY: if the file is generated, it has at least one line *)
    let lines = lines |> List.map int_of_string in
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

  let of_trace (trace : int list) = of_list (AUtil.pairs trace)

  let read file =
    let open AUtil in
    let traces = BlockTrace.read file in
    traces |> List.map pairs |> List.map of_list |> List.fold_left union empty

  let pp covset = iter (fun (i1, i2) -> L.debug "%d %d\n" i1 i2) covset
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

(* Interprocedural call-flow graph *)

(** A node in CFG, represent a basic block in LLVM IR *)
module Node = struct
  type t = {
    order : int;
    filename : string;
    func_name : string;
    line : int;
    addr : int;
  }

  let to_tuple n = (n.order, n.filename, n.func_name, n.line, n.addr)
  let compare = compare
  let hash n = n.addr
  let equal n1 n2 = compare n1 n2 = 0

  let pp fmt n =
    Format.fprintf fmt "%s:%s:%d:%d:0x%x" n.filename n.func_name n.line n.order
      n.addr
end

(* A node in Call Graph, used for AFLGo-style distance metric *)
module FuncNode = struct
  type t = string

  let compare = compare
  let hash = Hashtbl.hash
  let equal = ( = )
  let pp fmt n = Format.fprintf fmt "Function %s" n
end

module AddrToNode = struct
  include Hashtbl.Make (struct
    type t = int

    let hash = Hashtbl.hash
    let equal = ( = )
  end)

  let of_assoc assoc =
    let tbl = create (List.length assoc) in
    List.iter (fun (k, v) -> add tbl k v) assoc;
    tbl
end

module Edge = struct
  type t = Call | Flow
  type vertex = Node.t

  let default = Flow
  let compare = compare
  let to_val = function Call -> 10.0 | Flow -> 1.0
end

module G = Graph.Imperative.Digraph.ConcreteLabeled (Node) (Edge)

module ControlFlowGraph : sig
  type t = { func_name : string; g : G.t }

  val func_name : t -> string
  val graph : t -> G.t
  val of_dot_file : string -> t option
  val merge_cfgs : t list -> (string, G.vertex) Hashtbl.t * G.t
end = struct
  open Graph

  type t = { func_name : string; g : G.t }

  let func_name t = t.func_name
  let graph t = t.g

  (* A label looks like: label="{InstCombineMulDivRem.cpp:_ZN4llvm16InstCombinerImpl9visitURemERNS_14BinaryOperatorE:0:0}" *)
  (* filename:line:order *)
  let parse_label s =
    try
      let trimmed = String.sub s 1 (String.length s - 2) in
      let chunks = String.split_on_char ':' trimmed in
      match chunks with
      | [ filename; func_name; line; order ] ->
          (filename, func_name, int_of_string line, int_of_string order)
      | _ -> raise (Invalid_argument "invalid label format")
    with _ ->
      let msg = Format.asprintf "invalid label format: %s" s in
      raise (Invalid_argument msg)

  let get_node_addr node_id =
    match node_id with
    | Dot_ast.Ident s, _ ->
        String.sub s 4 (String.length s - 4) |> int_of_string
    | _ -> failwith "invalid node id"

  let get_node_label attrs =
    attrs |> List.find_map (fun attr -> List.assoc (Dot_ast.Ident "label") attr)

  module Parser =
    Dot.Parse
      (Builder.I
         (G))
         (struct
           let node node_id attrs =
             let addr = get_node_addr node_id in
             let label = get_node_label attrs in
             match label with
             | Some (Dot_ast.String s) ->
                 let filename, func_name, line, order = parse_label s in
                 G.V.create { filename; func_name; line; order; addr }
             | _ ->
                 G.V.create
                   {
                     filename = "unknown";
                     func_name = "unknown";
                     line = -1;
                     order = -1;
                     addr;
                   }

           let edge _attrs = Edge.default
         end)

  let of_dot_file filename =
    let g =
      try Parser.parse filename
      with _ ->
        raise (Invalid_argument ("invalid dot file format of " ^ filename))
    in

    (* pick any vertex in the graph *)
    let v = G.fold_vertex (fun node _ -> Some node.func_name) g None in
    match v with Some func_name -> Some { func_name; g } | None -> None

  let choose_first_node g =
    let nodes = G.fold_vertex (fun node accu -> node :: accu) g [] in
    nodes |> List.find (fun (node : Node.t) -> node.order = 0)

  let merge_cfgs cfgs =
    let nb_nodes =
      cfgs |> List.map (fun { g; _ } -> G.nb_vertex g) |> List.fold_left ( + ) 0
    in
    let funcname_to_node = Hashtbl.create nb_nodes in
    let merged_cfg = G.create () in

    cfgs
    |> List.iter (fun { func_name; g } ->
           let first_node = choose_first_node g in
           if not @@ Hashtbl.mem funcname_to_node func_name then
             Hashtbl.add funcname_to_node func_name first_node;

           G.iter_vertex (G.add_vertex merged_cfg) g;
           G.iter_edges_e (G.add_edge_e merged_cfg) g);

    (funcname_to_node, merged_cfg)
end

module CallGraph = struct
  type t = G.t

  let parse_calledge_node caller_node : Node.t =
    match String.split_on_char ':' caller_node with
    | [ filename; func_name; line; order; addr ] ->
        {
          filename;
          func_name;
          line = int_of_string line;
          order = int_of_string order;
          addr = int_of_string addr;
        }
    | _ -> raise (Invalid_argument "invalid caller_node format")

  let read filename =
    let lines = AUtil.readlines filename in
    (* InstructionSimplify.cpp:_ZL15simplifySubInstPN4llvm5ValueES1_bbRKNS_13SimplifyQueryEj:863:77:94208524658352 _ZL15simplifyXorInstPN4llvm5ValueES1_RKNS_13SimplifyQueryEj *)
    lines
    |> List.map (fun line ->
           match String.split_on_char ' ' line with
           | [ caller_node; called_fn ] ->
               (parse_calledge_node caller_node, called_fn)
           | _ -> raise (Invalid_argument "invalid callgraph format"))

  module FunctionCallGraph =
    Graph.Imperative.Digraph.ConcreteLabeled
      (FuncNode)
      (struct
        type t = float

        let default = 10.0
        let compare = compare
      end)

  let to_function_call_graph calledges =
    let g = FunctionCallGraph.create () in
    calledges
    |> List.iter (fun (caller_node, called_fn) ->
           let caller = caller_node.Node.func_name in
           let called = called_fn in
           let edge = FunctionCallGraph.E.create caller 10.0 called in
           FunctionCallGraph.add_edge_e g edge);

    g
end

module FullGraph = struct
  type t = G.t

  let of_cfgs_and_calledges cfgs calledges =
    let func_to_node, cfg = ControlFlowGraph.merge_cfgs cfgs in

    calledges
    |> List.iter (fun (caller_node, called_fn) ->
           try
             let called_node = Hashtbl.find func_to_node called_fn in
             let edge = G.E.create caller_node Edge.Call called_node in
             G.add_edge_e cfg edge
           with Not_found -> L.debug "Function %s not found in CFG" called_fn);
    cfg

  let find_targets (filename, lineno) cfg =
    G.fold_vertex
      (fun v accu ->
        if v.filename = filename && v.line = lineno then v :: accu else accu)
      cfg []
end

module FuncNameMap = Map.Make (Node)

module DistanceTable = struct
  module Dijk =
    Graph.Path.Dijkstra
      (G)
      (struct
        type edge = G.E.t
        type t = float

        let weight e = G.E.label e |> Edge.to_val
        let compare = compare
        let add = Float.add
        let zero = 0.0
      end)

  include Map.Make (Node)

  let compute_distances cfg target =
    let dijk v =
      try
        let _, length = Dijk.shortest_path cfg v target in
        Some length
      with Not_found -> None
    in
    G.fold_vertex
      (fun v accu ->
        match dijk v with Some dist -> add v dist accu | None -> accu)
      cfg empty

  module FloatSet = Set.Make (Float)

  let harmonic_avg fset =
    let sum = FloatSet.fold (fun x accu -> accu +. (1.0 /. x)) fset 0.0 in
    Float.of_int (FloatSet.cardinal fset) /. sum

  let build_distmap cfg target_nodes =
    target_nodes
    |> List.map (fun target -> compute_distances cfg target)
    |> List.map (map (fun d -> FloatSet.singleton d))
    |> List.fold_left
         (union (fun _k d1 d2 -> FloatSet.union d1 d2 |> Option.some))
         empty
    |> map harmonic_avg
  (* block-level distance in a CFG uses harmonic mean *)

  module FuncLevelDijk =
    Graph.Path.Dijkstra
      (CallGraph.FunctionCallGraph)
      (struct
        type t = float
        type edge = string * float * string

        let compare = Float.compare
        let weight _ = 10.0
        let add = Float.add
        let zero = 0.0
      end)

  let compute_distance_aflgo cfg cg calledges target =
    G.fold_vertex
      (fun v accu ->
        if v.func_name = target.Node.func_name then
          try
            let _path, bbdist = Dijk.shortest_path cfg v target in
            add v bbdist accu
          with Not_found -> accu
        else
          let callsites =
            List.filter
              (fun (caller, _callee) -> caller.Node.func_name = v.func_name)
              calledges
          in

          let dists =
            callsites
            |> List.filter_map (fun (caller, callee) ->
                   try
                     let _, bbdist = Dijk.shortest_path cfg v caller in
                     let _, fdist =
                       FuncLevelDijk.shortest_path cg callee
                         target.Node.func_name
                     in
                     Some (bbdist +. fdist +. 10.0)
                   with Not_found -> None)
          in

          if dists = [] then accu
          else
            let min_dist = dists |> List.fold_left min infinity in
            add v min_dist accu)
      cfg empty

  let build_distmap_aflgo cfgs cg calledges target_nodes =
    let merged_cfg = G.create () in
    cfgs
    |> List.iter (fun cfg ->
           G.iter_vertex (G.add_vertex merged_cfg) cfg.ControlFlowGraph.g;
           G.iter_edges_e (G.add_edge_e merged_cfg) cfg.ControlFlowGraph.g);

    target_nodes
    |> List.map (fun target ->
           compute_distance_aflgo merged_cfg cg calledges target)
    |> List.map (map (fun d -> FloatSet.singleton d))
    |> List.fold_left
         (union (fun _k d1 d2 -> FloatSet.union d1 d2 |> Option.some))
         empty
    |> map harmonic_avg
end

let node_of_addr node_tbl distmap addr =
  match AddrToNode.find_opt node_tbl addr with
  | None -> None (* in CFG of a function other than the target function *)
  | Some node -> if DistanceTable.mem node distmap then Some node else None

let load_cfgs_from_dir cfg_dir =
  Sys.readdir cfg_dir
  |> Array.to_list
  |> List.map (fun filename -> Filename.concat cfg_dir filename)
  |> List.filter (fun filename -> Filename.check_suffix filename ".dot")
  |> List.filter_map ControlFlowGraph.of_dot_file

module CfgDistance = struct
  type t = float

  (** computes distance of a trace *)
  let distance_score (trace : BlockTrace.t) node_tbl distmap =
    let nodes = trace |> List.filter_map (node_of_addr node_tbl distmap) in
    if nodes = [] then 65535.0
    else
      let dist_sum : float =
        nodes
        |> List.filter_map (fun node -> DistanceTable.find_opt node distmap)
        |> List.fold_left (fun sum dist -> sum +. dist) 0.0
      in
      let size = List.length nodes in
      dist_sum /. float_of_int size

  let get_cover (trace : BlockTrace.t) node_tbl distmap =
    trace
    |> List.exists (fun addr ->
           let node = AddrToNode.find_opt node_tbl addr in
           match node with
           | None -> false
           | Some node -> DistanceTable.find_opt node distmap = Some 0.0)
end
