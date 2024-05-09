type mutation_t = CREATE | OPCODE | OPERAND | FLAG | TYPE | CUT

let pp_mutation fmt m =
  match m with
  | CREATE -> Format.fprintf fmt "CREATE"
  | OPCODE -> Format.fprintf fmt "OPCODE"
  | OPERAND -> Format.fprintf fmt "OPERAND"
  | FLAG -> Format.fprintf fmt "FLAG"
  | TYPE -> Format.fprintf fmt "TYPE"
  | CUT -> Format.fprintf fmt "CUT"

let default_mutation_tbl =
  [|
    (CREATE, 0);
    (OPCODE, 100);
    (OPERAND, 100);
    (FLAG, 100);
    (TYPE, 100);
    (CUT, 100);
  |]

let default_expand_mutation_tbl =
  [| (OPCODE, 3); (OPERAND, 3); (FLAG, 3); (TYPE, 2); (CUT, 1) |]

let default_focus_mutation_tbl =
  [| (OPCODE, 3); (OPERAND, 3); (FLAG, 1); (TYPE, 2) |]

module MutationWeightMap = struct
  module MutMap = Map.Make (struct
    type t = mutation_t

    let compare = compare
  end)

  type t = int MutMap.t

  let default = default_mutation_tbl |> Array.to_seq |> MutMap.of_seq
  let expand_tbl = default_expand_mutation_tbl |> Array.to_seq |> MutMap.of_seq
  let focus_tbl = default_focus_mutation_tbl |> Array.to_seq |> MutMap.of_seq

  let choose m =
    let sum = MutMap.fold (fun _ v accu -> accu + v) m 0 in
    let goal = Random.int sum in
    let ret_opt =
      MutMap.fold
        (fun k v accu ->
          match accu with
          | Either.Right _ -> accu
          | Left accu_sum ->
              let accu_sum = accu_sum + v in
              if accu_sum > goal then Right k else Left accu_sum)
        m (Left 0)
    in
    ret_opt |> Either.find_right |> Option.get

  let update mut w_inc m =
    let w_old = MutMap.find mut m in
    let w_new = w_old + w_inc in
    let w_new = if w_new > 1 then w_new else 1 in
    MutMap.add mut w_new m

  let pp fmt m =
    MutMap.iter
      (fun k v ->
        pp_mutation fmt k;
        Format.fprintf fmt " |-> %d@." v)
      m
end

module ScoreMutationWeightMap = struct
  module ScoreMap = Map.Make (Float)

  type t = MutationWeightMap.t ScoreMap.t

  let empty = ScoreMap.empty

  let get path m =
    match ScoreMap.find_opt path m with
    | Some mw_map -> mw_map
    | None -> MutationWeightMap.default

  let update path mut w m =
    let mw_map = get path m in
    ScoreMap.add path (MutationWeightMap.update mut w mw_map) m

  let pp fmt m =
    ScoreMap.iter
      (fun k v ->
        Format.fprintf fmt "table for score %.2f:@." k;
        MutationWeightMap.pp fmt v)
      m
end
