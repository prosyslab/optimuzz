open Util

let main () =
  let llctx = ALlvm.create_context () in
  let llm = ALlvm.read_ll llctx Sys.argv.(1) |> Result.get_ok in

  Logger.from_file "debug.log";
  Logger.set_level Logger.DEBUG;

  Logger.debug "before:\n%s" (ALlvm.string_of_llmodule llm);
  (match Mutation.Mutator.cut_below llctx llm with
  | None -> Logger.debug "no change"
  | Some llm' -> Logger.debug "after:\n%s" (ALlvm.string_of_llmodule llm'));

  ()

let _ = main ()
