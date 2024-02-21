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

  Logger.from_file "debug.log";
  Logger.set_level Logger.DEBUG;

  Random.init 1004;

  Logger.debug "tgt: %s" (ALlvm.string_of_llvalue tgt);
  Logger.debug "before:\n%s" (ALlvm.string_of_llmodule llm);
  (match Fuzz.Mutator.create_rand_instr llctx None tgt with
  | None -> Logger.debug "no mutation"
  | Some mut_instr ->
      Logger.debug "mutated: %s" (ALlvm.string_of_llvalue mut_instr));
  Logger.debug "after:\n%s" (ALlvm.string_of_llmodule llm);

  Logger.flush ();
  Logger.finalize ();
  ()

let _ = main ()
