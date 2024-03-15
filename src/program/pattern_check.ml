open Util

let pattern_path = ref ""
let out_dir = ref "."

let speclist =
  [
    ("--pattern", Arg.Set_string pattern_path, "Path to the pattern file");
    ( "--out-dir",
      Arg.Set_string out_dir,
      "Output directory for the generated LLVM IR" );
  ]

let pattern_check pattern_path llset () =
  let name, pat = pattern_path |> Pattern.Parser.run in
  let all_instances = Pattern.Instantiation.run name pat in
  List.iter
    (fun llm ->
      match ALlvm.LLModuleSet.get_new_name llset llm with
      | None -> ()
      | Some filename -> ALlvm.save_ll !out_dir filename llm |> ignore)
    all_instances;
  exit 0

let _ =
  Arg.parse speclist print_endline "Usage: pattern_check [OPTION]...";
  let llset = ALlvm.LLModuleSet.create 4096 in
  pattern_check !pattern_path llset ()
