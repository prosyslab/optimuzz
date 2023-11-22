open Coverage.Domain
open Util

type res_t = CRASH | INVALID | VALID

let cmd = AUtil.command_args

let clean filename =
  let _ = cmd [ "rm"; filename; "/dev/null" ] in
  (* if exit_state = 0 then VALID else CRASH *)
  ()

let run_alive2 filename =
  (* run alive2 *)
  let exit_state =
    cmd
      [
        !Config.alive2_bin;
        filename;
        AUtil.name_opted_ver filename;
        "| tail -n 4 >";
        AUtil.alive2_log;
      ]
  in

  (* review result *)
  if exit_state <> 0 then CRASH
  else
    let file = open_in AUtil.alive2_log in
    let rec loop accu =
      match input_line file with
      | exception End_of_file -> accu
      | line -> loop (line :: accu)
    in
    let lines = [] |> loop |> List.rev in
    close_in file;

    let is_num_zero str =
      str |> String.trim |> String.split_on_char ' ' |> List.hd |> int_of_string
      = 0
    in
    let str_incorrect = List.nth lines 1 in
    if is_num_zero str_incorrect then VALID else INVALID

let run_opt filename =
  let exit_state =
    cmd
      [
        !Config.opt_bin;
        filename;
        "-S";
        "--passes=instcombine";
        "-o";
        (* AUtil.name_opted_ver filename; *)
        "/dev/null";
      ]
  in
  if exit_state = 0 then VALID else CRASH

(* run opt (and tv) and measure coverage *)
let run_bins filename llm =
  Coverage.Measurer.clean ();
  ALlvm.save_ll !Config.out_dir filename llm;
  let filename_out = Filename.concat !Config.out_dir filename in

  (* run opt/alive2 and evaluate *)
  let res_opt = run_opt filename_out in
  clean filename_out;
  let coverage =
    if res_opt = CRASH then CovSet.singleton !Config.max_distance
    else Coverage.Measurer.run ()
  in
  if !Config.no_tv then (
    if res_opt <> VALID then ALlvm.save_ll !Config.crash_dir filename llm;
    (res_opt, coverage))
  else
    let res_alive2 = run_alive2 filename_out in
    if res_alive2 <> VALID then ALlvm.save_ll !Config.crash_dir filename llm;
    (res_alive2, coverage)
