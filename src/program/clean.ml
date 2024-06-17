open Seedcorpus
open Util

let main seed_dir =
  let llctx = ALlvm.create_context () in
  Seedpool.collect_cleaned_seeds llctx seed_dir

let _ =
  Printexc.record_backtrace true;
  if Sys.argv |> Array.length <> 3 then
    Format.eprintf "Usage: %s <seed_dir> <out_dir>@." Sys.argv.(0)
  else
    let seed_dir = Sys.argv.(1) in
    let out_dir = Filename.concat (Sys.getcwd ()) Sys.argv.(2) in

    Format.printf "seed_dir: %s@." seed_dir;
    Format.printf "out_dir: %s@." out_dir;

    assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);
    assert (not (Sys.file_exists out_dir));

    Sys.mkdir out_dir 0o755;
    assert (Sys.file_exists out_dir);

    Logger.from_file "cleaned_seeds.log";
    Config.opt_bin := "./opt";
    let cleaned_seeds = main seed_dir in

    cleaned_seeds
    |> List.iter (fun llm ->
           let filename = ALlvm.hash_llm llm |> Format.sprintf "id:%010d.ll" in
           ALlvm.save_ll out_dir filename llm |> ignore)
