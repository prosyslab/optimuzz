open Util

let main () =
  let llctx = ALlvm.create_context () in
  Config.initialize llctx ();

  let llm = ALlvm.read_ll llctx Sys.argv.(1) in
  let func = ALlvm.choose_function llm in
  let all_instrs =
    ALlvm.fold_left_all_instr (fun acc instr -> instr :: acc) [] func
  in
  let n = int_of_string Sys.argv.(2) in
  let tgt = List.nth all_instrs n in

  Format.eprintf "before: %s@." (ALlvm.string_of_llmodule llm);
  Format.eprintf "tgt: %s@." (ALlvm.string_of_llvalue tgt);
  Fuzz.Mutator.change_type llctx tgt |> ignore;
  Format.eprintf "after: %s@." (ALlvm.string_of_llmodule llm);
  ()

let _ = main ()
