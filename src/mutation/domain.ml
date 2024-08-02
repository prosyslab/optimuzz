open Util

type opcode_t = ICMP of ALlvm.Icmp.t | OTHER of ALlvm.Opcode.t
type mode_t = EXPAND | FOCUS
type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE | CUT

let pp_mutation fmt m =
  match m with
  | CREATE -> Format.fprintf fmt "CREATE"
  | OPCODE -> Format.fprintf fmt "OPCODE"
  | OPERAND -> Format.fprintf fmt "OPERAND"
  | FLAG -> Format.fprintf fmt "FLAG"
  | TYPE -> Format.fprintf fmt "TYPE"
  | CUT -> Format.fprintf fmt "CUT"

let uniform_mutations =
  [ (CREATE, 1); (OPCODE, 1); (OPERAND, 1); (FLAG, 1); (TYPE, 1); (CUT, 1) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let expand_mutations =
  [ (CREATE, 2); (OPCODE, 4); (OPERAND, 4); (FLAG, 3); (TYPE, 2); (CUT, 1) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let focus_mutations =
  [ (OPCODE, 3); (OPERAND, 3); (FLAG, 1); (TYPE, 2) ]
  |> List.map (fun (m, p) -> List.init p (Fun.const m))
  |> List.flatten
  |> Array.of_list

let pp_opcode fmt opc =
  match opc with
  | ICMP pred -> Format.fprintf fmt "ICmp %s" (ALlvm.string_of_icmp pred)
  | OTHER opc -> Format.fprintf fmt "%s" (ALlvm.string_of_opcode opc)

let get_icmp opc =
  match opc with
  | ICMP pred -> pred
  | OTHER _ -> failwith "opdoce_t is not ICMP"

let get_other opc =
  match opc with
  | OTHER opc_new -> opc_new
  | ICMP _ -> failwith "opdoce_t is not OTHER"

module OpcodeWeightMap = struct
  module OpcMap = Map.Make (struct
    type t = opcode_t

    let compare = compare
  end)

  type t = Int.t OpcMap.t

  let choose m =
    let sum = OpcMap.fold (fun _ v accu -> accu + v) m 0 in
    let goal = Random.int sum in
    let ret_opt =
      OpcMap.fold
        (fun k v accu ->
          match accu with
          | Either.Right _ -> accu
          | Left accu_sum ->
              let accu_sum = accu_sum + v in
              if accu_sum > goal then Right k else Left accu_sum)
        m (Left 0)
    in
    ret_opt |> Either.find_right |> Option.get

  let initilize_icmp =
    Array.map (fun pred_tgt -> (ICMP pred_tgt, 100)) ALlvm.OpcodeClass.icmp_kind
    |> Array.to_seq
    |> OpcMap.of_seq

  let initilize_opcode opc =
    match ALlvm.OpcodeClass.classify opc with
    | BINARY ->
        Array.map (fun opc -> (OTHER opc, 100)) ALlvm.OpcodeClass.binary_arr
        |> Array.to_seq
        |> OpcMap.of_seq
    | CAST when opc = Trunc ->
        [| (OTHER Trunc, 100) |] |> Array.to_seq |> OpcMap.of_seq
    | CAST ->
        [| (OTHER SExt, 100); (OTHER ZExt, 100) |]
        |> Array.to_seq
        |> OpcMap.of_seq
    | _ -> failwith "NEVER OCCUR"

  let initialize opc =
    match opc with
    | ICMP _ -> initilize_icmp
    | OTHER opc -> initilize_opcode opc

  let update opc w_inc m =
    let w_old = OpcMap.find opc m in
    let w_new = w_old + w_inc in
    let w_new = if w_new > 1 then w_new else 1 in
    OpcMap.add opc w_new m

  let pp fmt m =
    OpcMap.iter
      (fun k v ->
        match k with
        | ICMP pred ->
            Format.fprintf fmt " |-> %s@." (ALlvm.string_of_icmp pred);
            Format.fprintf fmt " |-> %d@." v
        | OTHER opc ->
            Format.fprintf fmt " |-> %s@." (ALlvm.string_of_opcode opc);
            Format.fprintf fmt " |-> %d@." v)
      m
end

module OpcodeMap = struct
  module OpcMap = Map.Make (struct
    type t = opcode_t

    let compare = compare
  end)

  type t = OpcodeWeightMap.t OpcMap.t

  let empty = OpcMap.empty

  let get opcode m =
    match OpcMap.find_opt opcode m with
    | Some mw_map -> mw_map
    | None -> OpcodeWeightMap.initialize opcode

  let update opcode mut w m =
    let mw_map = get opcode m in
    OpcMap.add opcode (OpcodeWeightMap.update mut w mw_map) m

  let pp fmt m =
    OpcMap.iter
      (fun opc map ->
        Format.fprintf fmt "table for score %a:@." pp_opcode opc;
        OpcodeWeightMap.pp fmt map)
      m
end
