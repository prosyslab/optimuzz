open Util

let main () =
  let llctx = ALlvm.create_context () in
  let llm = ALlvm.read_ll llctx Sys.argv.(1) in
  let func = ALlvm.choose_function llm in
  let all_instrs =
    ALlvm.fold_left_all_instr (fun acc instr -> instr :: acc) [] func
  in
  let n = int_of_string Sys.argv.(2) in
  let tgt = List.nth all_instrs n in

  Config.set_interesting_types llctx;

  ALlvm.dump_value tgt;
  ALlvm.dump_module llm;
  Fuzz.Mutator.change_type llctx tgt |> ignore;
  ALlvm.dump_module llm;
  ()

let _ = main ()
