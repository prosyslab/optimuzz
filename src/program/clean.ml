open Seedcorpus
open Util

let main seed_dir =
  let llctx = ALlvm.create_context () in
  Seedpool.collect_cleaned_seeds llctx seed_dir

let _ =
  if Sys.argv |> Array.length <> 3 then
    Format.eprintf "Usage: %s <seed_dir> <out_dir>@." Sys.argv.(0)
  else
    let seed_dir = Sys.argv.(1) in
    let out_dir = Sys.argv.(2) in
    Logger.from_file "cleaned_seeds.log";
    Config.opt_bin := "./opt";
    let cleaned_seeds = main seed_dir in
    cleaned_seeds
    |> List.iter (fun llm ->
           let cache_dir = Filename.concat (Sys.getcwd ()) out_dir in
           let filename = ALlvm.hash_llm llm |> Format.sprintf "id:%010d.ll" in
           ALlvm.save_ll cache_dir filename llm |> ignore)
