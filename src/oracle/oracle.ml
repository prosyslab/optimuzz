open Coverage.Domain
open Util

type res_t = CRASH | INVALID | VALID

let clean filename =
  AUtil.cmd [ "rm"; filename; "/dev/null"; "2> /dev/null" ] |> ignore

let run_alive2 filename =
  let opted_filename = AUtil.name_opted_ver filename in
  if Sys.file_exists filename && Sys.file_exists opted_filename then
    (* run alive2 *)
    let exit_state =
      AUtil.cmd
        [
          !Config.alive_tv_bin;
          filename;
          opted_filename;
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
      if is_num_zero str_incorrect then VALID else INVALID
  else VALID

let optimizer_passes =
  [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ]

(** [Optimizer] runs LLVM optimizer binary for specified passes and input IR.
    The input can be a file or LLVM module. *)
module Optimizer = struct
  let run ~passes ?output filename =
    let passes = "--passes=\"" ^ String.concat "," passes ^ "\"" in
    let output =
      match output with None -> "/dev/null" | Some x -> AUtil.name_opted_ver x
    in
    let exit_state =
      Util.AUtil.cmd [ !Config.opt_bin; filename; "-S"; passes; "-o"; output ]
    in
    if exit_state = 0 then VALID else CRASH

  let run_for_llm ~passes llm =
    let filename = AUtil.get_new_name (ALlvm.string_of_llmodule llm) in
    if filename = "" then INVALID
    else (
      (* transofrm input into a file for the optimizer *)
      ALlvm.save_ll !Config.out_dir filename llm;
      let input = Filename.concat !Config.out_dir filename in
      let result = run ~passes input in
      clean input;
      result)
end

(* run opt (and tv) and measure coverage *)
let run_bins filename llm =
  Coverage.Measurer.clean ();
  ALlvm.save_ll !Config.out_dir filename llm;
  let filename_out = Filename.concat !Config.out_dir filename in

  (* run opt/alive2 and evaluate *)
  let res_opt = Optimizer.run ~passes:optimizer_passes filename_out in
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
    clean filename_out;
    clean (AUtil.name_opted_ver filename_out);
    (res_alive2, coverage)
