open IR

(* do not care of inner/outer whitespaces, they are removed initially *)
(* FIXME: inefficient *)

(** [brack s] splits string [s]
    of form ["a(b(), c(d), e(f, g))"] into [("a", Some ["b()"; "c(d)"; "e(f, g)"])].
    If [s] does not open parenthesis, returns [(s, None)].
    @raise Invalid_argument if parentheses in [s] are not properly matched. *)
let brack s =
  let open String in
  if exists (( = ) '(') s then (
    let idx_open = index s '(' in
    let s_outer = sub s 0 idx_open in
    let s_inner = sub s (idx_open + 1) (length s - idx_open - 2) in
    let _, depth_end, idxs_cut =
      fold_left
        (fun (idx, depth, accu) c ->
          if depth = 0 && c = ',' then (idx + 1, depth, idx :: accu)
          else if c = '(' then (idx + 1, depth + 1, accu)
          else if c = ')' then (idx + 1, depth - 1, accu)
          else (idx + 1, depth, accu))
        (0, 0, []) s_inner
    in
    if depth_end <> 0 then raise (Invalid_argument s);
    let chunk0, chunks =
      List.fold_left
        (fun (s, accu) idx_cut ->
          (sub s 0 idx_cut, sub s (idx_cut + 1) (length s - idx_cut - 1) :: accu))
        (s_inner, []) idxs_cut
    in
    (s_outer, Some (if chunk0 = "" then [] else chunk0 :: chunks)))
  else (s, None)

let rec parse_single_match pat_raw =
  let name, sps_raw_opt = brack pat_raw in
  (* TODO: handle more cases *)
  match sps_raw_opt with
  | Some sps_raw -> (
      if sps_raw = [] then
        match name with
        | "m_Value" -> Any
        | "m_Undef" -> Var "UNDEF"
        | "m_Poison" -> Var "POISON"
        (* FIXME: m_constant requires no type constraint *)
        | "m_Constant" -> Const ("Any constant", IntCstr (Fun.const true))
        | "m_ConstantInt" -> Const ("Any int", IntCstr (Fun.const true))
        | "m_ConstantFP" -> Const ("Any float", FloatCstr (Fun.const true))
        | "m_AllOnes" -> Const ("-1", IntCstr (( = ) (-1)))
        | "m_Negative" -> Const ("Negative", IntCstr (( > ) 0))
        | "m_NonNegative" -> Const ("Nonnegative", IntCstr (( <= ) 0))
        | "m_StrictlyPositive" -> Const ("Positive", IntCstr (( < ) 0))
        | "m_NonPositive" -> Const ("Nonpositive", IntCstr (( >= ) 0))
        | "m_One" -> Const ("1", IntCstr (( = ) 1))
        | "m_Power2" ->
            Const ("2^n", IntCstr (fun x -> x > 0 && x land (x - 1) = 0))
        | "m_NegatedPower2" ->
            Const ("-2^n", IntCstr (fun x -> x < 0 && -x land (-x - 1) = 0))
        | "m_Power2OrZero" ->
            Const ("2^n (or zero)", IntCstr (fun x -> x land (x - 1) = 0))
        (* FIXME: no diff between following two matches *)
        | "m_ZeroInt" -> Const ("0", IntCstr (( = ) 0))
        | "m_Zero" -> Const ("0", IntCstr (( = ) 0))
        | "m_NaN" -> Const ("NaN", FloatCstr Float.is_nan)
        | "m_NonNaN" ->
            Const ("Not NaN", FloatCstr (fun x -> x |> Float.is_nan |> not))
        | "m_Inf" -> Const ("INF", FloatCstr Float.is_infinite)
        | "m_NonInf" ->
            Const ("Not INF", FloatCstr (fun x -> x |> Float.is_nan |> not))
        | "m_Finite" -> Const ("FIN", FloatCstr Float.is_finite)
        | "m_FiniteNonZero" ->
            Const
              ("FIN not 0.", FloatCstr (fun x -> Float.is_finite x && x != 0.0))
        (* FIXME: OCaml does not distinguish pos/neg zero. *)
        | "m_AnyZeroFP" -> Const ("+-0.", FloatCstr (( = ) 0.0))
        | "m_PosZeroFP" -> Const ("+0.", FloatCstr (( = ) 0.0))
        | "m_NegZeroFP" -> Const ("-0.", FloatCstr (( = ) 0.0))
        | "m_NonZeroFP" -> Const ("Not 0.", FloatCstr (( != ) 0.0))
        | "m_FPOne" -> Const ("1.", FloatCstr (( = ) 1.0))
        | _ -> raise (Invalid_argument name)
      else
        let sps = List.map parse_single_match sps_raw in
        match name with
        | "m_Value" | "m_Specific" -> List.hd sps
        | "m_Neg" ->
            BinOp (Sub, false, Const ("0", IntCstr (( = ) 0)), List.hd sps)
        | "m_Not" ->
            BinOp (Xor, false, Const ("-1", IntCstr (( = ) (-1))), List.hd sps)
        | _ ->
            let lhs = List.hd sps in
            let rhs = sps |> List.tl |> List.hd in
            if String.starts_with ~prefix:"m_c_" name then
              BinOp
                ( binop_of_string (String.sub name 4 (String.length name - 4)),
                  true,
                  lhs,
                  rhs )
            else
              BinOp
                ( binop_of_string (String.sub name 2 (String.length name - 2)),
                  false,
                  lhs,
                  rhs ))
  | None -> Var name

let run pat_filename =
  (* read all lines from file *)
  let pat_file = open_in pat_filename in
  let rec loop accu =
    try loop (input_line pat_file :: accu) with End_of_file -> accu
  in
  let lines = loop [] in
  close_in pat_file;

  (* parse each match *)
  let patmap =
    List.rev_map
      (fun line ->
        let _, inner_paren = brack line in
        let inner_paren = Option.get inner_paren in
        let name = List.hd inner_paren in
        let pat_raw = inner_paren |> List.tl |> List.hd in
        ( name,
          pat_raw |> String.trim
          |> Str.global_replace (Str.regexp " ") ""
          |> parse_single_match ))
      lines
    |> List.to_seq |> NameMap.of_seq
  in

  (* link all patterns *)
  link patmap
