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

(* tree of instructions, associating constraints to constants *)
(* 2 terminals, 1 nonterminal, 1 undetermined *)
(* TODO: non-operator nonterminals *)
type pat_t =
  (* Any allows Const, Var, or Operator; undetermined yet. *)
  | Any
  (* Const: constant; string is used only for debugging *)
  (* TODO: use Z3 expression *)
  | Const of string * (int -> bool)
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
