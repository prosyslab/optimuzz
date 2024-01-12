open Coverage.Domain
open Util

type res_t = CRASH | INVALID | VALID

(** [Validation] runs translation validation program (alive-tv).
    We use this program as an oracle to detect a miscompilation. *)
module Validator = struct
  let run src optimized =
    assert (optimized = AUtil.name_opted_ver src);
    if Sys.file_exists src && Sys.file_exists optimized then
      let exit_status =
        AUtil.cmd
          [
            !Config.alive_tv_bin;
            src;
            optimized;
            "| tail -n 4 >";
            AUtil.alive2_log;
          ]
      in
      match exit_status with
      | 0 ->
          let lines = AUtil.readlines AUtil.alive2_log in
          let is_num_zero str =
            str |> String.trim |> String.split_on_char ' ' |> List.hd
            |> int_of_string = 0
          in
          let str_incorrect = List.nth lines 1 in
          if is_num_zero str_incorrect then VALID else INVALID
      | _ -> CRASH
    else VALID
end

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
      AUtil.clean input;
      result)
end
