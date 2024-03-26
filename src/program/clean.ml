open Seedcorpus
open Util

let main input_file =
  let llctx = ALlvm.create_context () in
  Format.printf "input file: %s@." input_file;
  let llm = ALlvm.read_ll llctx input_file in
  Format.printf "input module: %s@." (ALlvm.string_of_llmodule llm);
  match Prep.clean_llm llctx true llm with
  | None ->
      Format.printf "clean failed@.";
      ()
  | Some llm ->
      Format.printf "clean succeeded@.";
      Format.printf "%s@." (ALlvm.string_of_llmodule llm);
      ()

let _ =
  let input = Sys.argv.(1) in
  if Sys.is_directory input then
    Sys.readdir input |> Array.map (Filename.concat input) |> Array.iter main
  else main Sys.argv.(1)
