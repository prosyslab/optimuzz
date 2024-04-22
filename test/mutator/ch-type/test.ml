open Util

let main () =
  let llctx = ALlvm.create_context () in
  let llm = ALlvm.read_ll llctx Sys.argv.(1) |> Result.get_ok in

  Config.set_interesting_types llctx;

  Logger.from_file "debug.log";
  Logger.set_level Logger.DEBUG;

  Logger.debug ~to_console:true "before:\n%s" (ALlvm.string_of_llmodule llm);
  (match Fuzz.Mutator.change_type llctx llm with
  | Some llm' ->
      Logger.debug ~to_console:true "after:\n%s" (ALlvm.string_of_llmodule llm')
  | None -> Logger.debug "no change");
  Logger.flush ();
  Logger.finalize ();
  ()

let _ = main ()
