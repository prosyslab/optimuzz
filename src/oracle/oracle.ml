open Coverage.Domain
open Util

type res_t = CRASH | INVALID | VALID

let clean filename =
  AUtil.cmd [ "rm"; filename; "/dev/null"; "2> /dev/null" ] |> ignore

let run_alive2 filename =
  let opted_filename = AUtil.name_opted_ver filename in
  if Sys.file_exists filename && Sys.file_exists opted_filename then (
    (* run alive2 *)
    let exit_state =
      AUtil.cmd
        [
          !Config.alive_tv_bin;
          filename;
          AUtil.name_opted_ver filename;
          "| tail -n 4 >";
          AUtil.alive2_log;
        ]
    in

    (* review result *)
    if exit_state <> 0 then CRASH
    else
      let lines = AUtil.readlines AUtil.alive2_log in
      let is_num_zero str =
        str |> String.trim |> String.split_on_char ' ' |> List.hd
        |> int_of_string = 0
      in
      let str_incorrect = List.nth lines 1 in
      if is_num_zero str_incorrect then VALID else INVALID)
  else VALID

let run_optimizer filename =
  let exit_state =
    Util.AUtil.cmd
      [
        !Config.opt_bin;
        filename;
        "-S";
        "--passes=\"globaldce,simplifycfg,instsimplify,instcombine\"";
        "-o";
        AUtil.name_opted_ver filename;
        (* "/dev/null"; *)
      ]
  in
  if exit_state = 0 then VALID else CRASH

let run_optimizer_llm llm =
  let filename = AUtil.get_new_name (ALlvm.string_of_llmodule llm) in
  if filename = "" then INVALID
  else (
    ALlvm.save_ll !Config.out_dir filename llm;
    let exit_state =
      AUtil.cmd
        [
          !Config.opt_bin;
          Filename.concat !Config.out_dir filename;
          "-S";
          (* "--passes=\"globaldce,simplifycfg,instsimplify,instcombine\""; *)
          "--passes=\"instcombine\"";
          "-o";
          (* AUtil.name_opted_ver filename; *)
          "/dev/null";
        ]
    in
    clean (Filename.concat !Config.out_dir filename);
    if exit_state = 0 then VALID else CRASH)

(* run opt (and tv) and measure coverage *)
let run_bins filename llm =
  Coverage.Measurer.clean ();
  ALlvm.save_ll !Config.out_dir filename llm;
  let filename_out = Filename.concat !Config.out_dir filename in

  (* run opt/alive2 and evaluate *)
  let res_opt = run_optimizer filename_out in
  let coverage =
    if res_opt = CRASH then CovSet.singleton !Config.max_distance
    else Coverage.Measurer.run ()
  in
  if !Config.no_tv then (
    if res_opt <> VALID then ALlvm.save_ll !Config.crash_dir filename llm;
    (* clean filename_out; *)
    clean filename_out;
    clean (AUtil.name_opted_ver filename_out);
    (res_opt, coverage))
  else
    let res_alive2 = run_alive2 filename_out in
    if res_alive2 <> VALID then ALlvm.save_ll !Config.crash_dir filename llm;
    (* clean filename_out; *)
    clean filename_out;
    clean (AUtil.name_opted_ver filename_out);
    (res_alive2, coverage)
