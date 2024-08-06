open Util

let main () =
  let llctx = ALlvm.create_context () in
  let llm = ALlvm.read_ll llctx Sys.argv.(1) |> Result.get_ok in

  Logger.from_file "debug.log";
  Logger.set_level Logger.DEBUG;

  Random.init 1004;

  Logger.debug "before:\n%s" (ALlvm.string_of_llmodule llm);
  (match Mutation.Mutator.create_rand_llv llctx llm with
  | None -> Logger.debug "no mutation"
  | Some llm' -> Logger.debug "mutated:\n%s" (ALlvm.string_of_llmodule llm'));

  Logger.flush ();
  Logger.finalize ();

  ()

let _ = main ()
