type binop_t =
  | Add
  | Sub
  | Mul
  | UDiv
  | SDiv
  | URem
  | SRem
  | Shl
  | LShr
  | AShr
  | And
  | Or
  | Xor
  | ICmp
  | FCmp

let string_of_binop = function
  | Add -> "Add"
  | Sub -> "Sub"
  | Mul -> "Mul"
  | UDiv -> "UDiv"
  | SDiv -> "SDiv"
  | URem -> "URem"
  | SRem -> "SRem"
  | Shl -> "Shl"
  | LShr -> "LShr"
  | AShr -> "AShr"
  | And -> "And"
  | Or -> "Or"
  | Xor -> "Xor"
  | ICmp -> "ICmp"
  | FCmp -> "FCmp"

let binop_of_string binop_str =
  match binop_str with
  | "Add" -> Add
  | "Sub" -> Sub
  | "Mul" -> Mul
  | "UDiv" -> UDiv
  | "SDiv" -> SDiv
  | "URem" -> URem
  | "SRem" -> SRem
  | "Shl" -> Shl
  | "LShr" -> LShr
  | "AShr" -> AShr
  | "And" -> And
  | "Or" -> Or
  | "Xor" -> Xor
  | "ICmp" -> ICmp
  | "FCmp" -> FCmp
  | _ -> raise (Invalid_argument binop_str)

type cstr_t = IntCstr of (int -> bool) | FloatCstr of (float -> bool)

(* tree of instructions, associating constraints to constants *)
type pat_t =
  (* Any: nonterminal (undetermined) placeholder *)
  | Any
  (* Const: constant; string is used only for debugging *)
  | Const of string * cstr_t
  (* Var: variable; includes undef and poison *)
  | Var of string
  (* Operator: (opcode, operands). *)
  | BinOp of binop_t * bool * pat_t * pat_t

let string_of_pat pat =
  let rec aux nSpaces pat =
    let indent = String.make nSpaces ' ' in
    indent
    ^
    match pat with
    | Any -> "ANYTHING"
    | Const (name, _) -> name
    | Var name -> name
    | BinOp (binop, comm, lhs, rhs) ->
        string_of_binop binop
        ^ (if comm then "-comm" else "")
        ^ "(\n"
        ^ aux (nSpaces + 2) lhs
        ^ ",\n"
        ^ aux (nSpaces + 2) rhs
        ^ "\n" ^ indent ^ ")"
  in
  aux 0 pat

module NameMap = Map.Make (String)

(** [link patmap] links patterns of different names into a single pattern. *)
let link patmap =
  let is_subpat spname pname =
    let rec aux = function
      | Any | Const _ -> false
      | Var name -> spname = name
      | BinOp (_, _, lhs, rhs) -> aux lhs || aux rhs
    in
    aux (NameMap.find pname patmap)
  in

  (* find root pattern; root pattern is subpattern of none *)
  let rootpat_name, rootpat =
    patmap
    |> NameMap.filter (fun rpname _ ->
           NameMap.for_all (fun pname _ -> not (is_subpat rpname pname)) patmap)
    |> NameMap.choose
  in

  (* substitute subpatterns *)
  let rec substitute pat =
    match pat with
    | Any | Const _ -> pat
    | Var name -> (
        match NameMap.find_opt name patmap with
        | Some sp -> substitute sp
        | None -> pat)
    | BinOp (binop, comm, lhs, rhs) ->
        BinOp (binop, comm, substitute lhs, substitute rhs)
  in

  (rootpat_name, substitute rootpat)
