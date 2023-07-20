type opcode_t =
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

let string_of_opcode = function
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

let opcode_of_string opcode_str =
  match opcode_str with
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
  | _ -> raise (Invalid_argument opcode_str)

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
  | Operator of opcode_t * pat_t list

let string_of_pat pat =
  let rec aux nSpaces pat =
    let indent = String.make nSpaces ' ' in
    indent
    ^
    match pat with
    | Any -> "ANYTHING"
    | Const (name, _) -> name
    | Var name -> name
    | Operator (opcode, sps) ->
        string_of_opcode opcode ^ "(\n"
        ^ (nSpaces + 2 |> aux |> (Fun.flip List.map) sps |> String.concat ",\n")
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
      | Operator (_, sps) -> List.exists aux sps
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
    | Operator (opcode, sps) -> Operator (opcode, List.map substitute sps)
  in

  (rootpat_name, substitute rootpat)
