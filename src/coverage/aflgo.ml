open Util

(* AFLGo style feedback using CFG and CG *)

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

module NodeTable = struct
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
  type t = float
  type vertex = Node.t

  let default = 1.0
  let compare = Float.compare
end

module G = Graph.Imperative.Digraph.ConcreteLabeled (Node) (Edge)

module ControlFlowGraph : sig
  type t

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

  let merge_cfgs cfgs =
    let nb_nodes =
      cfgs |> List.map (fun { g; _ } -> G.nb_vertex g) |> List.fold_left ( + ) 0
    in
    let tbl = Hashtbl.create nb_nodes in
    let merged = G.create () in

    cfgs
    |> List.iter (fun { func_name; g } ->
           G.iter_vertex
             (fun v ->
               Hashtbl.add tbl func_name v;
               G.add_vertex merged v)
             g;
           G.iter_edges_e (fun edge -> G.add_edge_e merged edge) g);

    (tbl, merged)
end

module CallGraph : sig
  type t

  val read : string -> (Node.t * string) list
end = struct
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
    (* InstCombineMulDivRem.cpp:_ZN4llvm16InstCombinerImpl9visitURemERNS_14BinaryOperatorE:1468:1 _ZN4llvm16InstCombinerImpl9visitURemERNS_14BinaryOperatorE *)
    lines
    |> List.map (fun line ->
           match String.split_on_char ' ' line with
           | [ caller_node; called_fn ] ->
               (parse_calledge_node caller_node, called_fn)
           | _ -> raise (Invalid_argument "invalid callgraph format"))
end

module FullGraph = struct
  type t = G.t

  let of_cfgs_and_calledges cfgs calledges =
    let func_to_node, cfg = ControlFlowGraph.merge_cfgs cfgs in

    calledges
    |> List.iter (fun (caller_node, called_fn) ->
           let called_node = Hashtbl.find func_to_node called_fn in
           let edge = G.E.create caller_node 10.0 called_node in
           G.add_edge_e cfg edge);
    cfg

  let find_targets (filename, lineno) cfg =
    G.fold_vertex
      (fun v accu ->
        if v.filename = filename && v.line = lineno then v :: accu else accu)
      cfg []
end

module DistanceTable : sig
  type 'a t

  val build_distmap : G.t -> Node.t list -> float t
  val is_empty : 'a t -> bool
  val iter : (Node.t -> 'a -> unit) -> 'a t -> unit
  val find_opt : Node.t -> float t -> float option
  val mem : Node.t -> 'a t -> bool
end = struct
  module Dijk =
    Graph.Path.Dijkstra
      (G)
      (struct
        type edge = G.E.t
        type t = float

        let weight e = G.E.label e
        let compare = compare
        let add = Float.add
        let zero = 0.0
      end)

  include Map.Make (Node)

  let compute_distances cfg target =
    let dijk v =
      try
        let path, length = Dijk.shortest_path cfg v target in
        Some (path, length)
      with Not_found -> None
    in
    G.fold_vertex
      (fun v accu ->
        let dist = dijk v |> Option.map snd in
        add v dist accu)
      cfg empty

  let build_distmap cfg target_nodes =
    let module FloatSet = Set.Make (Float) in
    let harmonic_avg fset =
      let sum = FloatSet.fold (fun x accu -> accu +. (1.0 /. x)) fset 0.0 in
      Float.of_int (FloatSet.cardinal fset) /. sum
    in
    target_nodes
    |> List.map (fun target ->
           compute_distances cfg target |> filter_map (fun _k v -> v))
    |> List.map (map (fun d -> FloatSet.singleton d))
    |> List.fold_left
         (union (fun _k d1 d2 -> FloatSet.union d1 d2 |> Option.some))
         empty
    |> map harmonic_avg (* block-level distance in a CFG uses harmonic mean *)
end
