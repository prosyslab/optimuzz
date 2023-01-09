module F = Format

type t =
  | S
  | Zero
  | One
  | X
  | Y
  | Plus of t * t
  | Minus of t * t
  | If of bexp * t * t

and bexp = Le of t * t | Eq of t * t | B

let terminals = [ Zero; One; X; Y ]

let rec pp fmt = function
  | Zero -> F.fprintf fmt "0"
  | One -> F.fprintf fmt "1"
  | X -> F.fprintf fmt "X"
  | Y -> F.fprintf fmt "Y"
  | If (b, e1, e2) -> F.fprintf fmt "If (%a, %a, %a)" pp_bexp b pp e1 pp e2
  | Plus (e1, e2) -> F.fprintf fmt "(%a + %a)" pp e1 pp e2
  | Minus (e1, e2) -> F.fprintf fmt "(%a - %a)" pp e1 pp e2
  | S -> F.fprintf fmt "S"

and pp_bexp fmt = function
  | Le (e1, e2) -> F.fprintf fmt "(%a <= %a)" pp e1 pp e2
  | Eq (e1, e2) -> F.fprintf fmt "(%a == %a)" pp e1 pp e2
  | B -> F.fprintf fmt "B"

let rec compile llctx builder f t =
  match t with
  | X -> Llvm.param f 0
  | Y -> Llvm.param f 1
  | Plus (l, r) ->
      let lv = compile llctx builder f l in
      let rv = compile llctx builder f r in
      Llvm.build_add lv rv "tmp" builder
  | Minus (l, r) ->
      let lv = compile llctx builder f l in
      let rv = compile llctx builder f r in
      Llvm.build_sub lv rv "tmp" builder
  | If (b, te, fe) ->
      let cond = compile_bexp llctx builder f b in
      let tb = Llvm.append_block llctx "tb" f in
      let fb = Llvm.append_block llctx "fb" f in
      let tbuilder = Llvm.builder_at_end llctx tb in
      let fbuilder = Llvm.builder_at_end llctx fb in
      let join = Llvm.append_block llctx "join" f in
      let lv = compile llctx tbuilder f te in
      let rv = compile llctx fbuilder f fe in
      let _ = Llvm.build_br join tbuilder in
      let _ = Llvm.build_br join fbuilder in
      let _ = Llvm.build_cond_br cond tb fb builder in
      let jbuilder = Llvm.builder_at_end llctx join in
      let phi = Llvm.build_phi [ (lv, tb); (rv, fb) ] "tmp" jbuilder in
      Llvm.position_builder (Llvm.At_end join) builder;
      phi
  | Zero -> Llvm.const_int (Llvm.i32_type llctx) 0
  | One -> Llvm.const_int (Llvm.i32_type llctx) 1
  | S -> failwith "Unable to compile non-terminals"

and compile_bexp llctx builder f bexp =
  match bexp with
  | Le (l, r) ->
      let lv = compile llctx builder f l in
      let rv = compile llctx builder f r in
      Llvm.build_icmp Llvm.Icmp.Sle lv rv "tmp" builder
  | Eq (l, r) ->
      let lv = compile llctx builder f l in
      let rv = compile llctx builder f r in
      Llvm.build_icmp Llvm.Icmp.Eq lv rv "tmp" builder
  | B -> failwith "Unable to compile non-terminals"

let to_llvm llctx llmem p =
  let llm = Llvm_irreader.parse_ir llctx llmem in
  let f =
    match Llvm.lookup_function "f" llm with
    | Some f -> f
    | None -> failwith "target funtion not found"
  in
  let entry = Llvm.entry_block f in
  let last = Llvm.instr_end entry in
  let last_instr =
    match last with Llvm.After i -> i | _ -> failwith "Instruction not found"
  in
  let builder = Llvm.builder_before llctx last_instr in
  let result = compile llctx builder f p in
  let _ = Llvm.build_ret result builder in
  Llvm.delete_instruction last_instr;
  llm

let rec eval p x y =
  match p with
  | Zero -> 0
  | One -> 1
  | X -> x
  | Y -> y
  | Plus (p1, p2) -> eval p1 x y + eval p2 x y
  | Minus (p1, p2) -> eval p1 x y - eval p2 x y
  | If (b, p1, p2) -> if eval_bexp b x y then eval p1 x y else eval p2 x y
  | S -> failwith "Unable to evaluate non-terminals"

and eval_bexp b x y =
  match b with
  | Le (p1, p2) -> eval p1 x y <= eval p2 x y
  | Eq (p1, p2) -> eval p1 x y = eval p2 x y
  | B -> failwith "Unable to evaluate non-terminals"
