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

  Logger.from_file "debug.log";
  Logger.set_level Logger.DEBUG;

  Logger.debug ~to_console:true "tgt: %s" (ALlvm.string_of_llvalue tgt);
  Logger.debug ~to_console:true "before:\n%s" (ALlvm.string_of_llmodule llm);
  Fuzz.Mutator.change_type llctx tgt |> ignore;
  Logger.debug ~to_console:true "after:\n%s" (ALlvm.string_of_llmodule llm);

  Logger.flush ();
  Logger.finalize ();
  ()

let _ = main ()
