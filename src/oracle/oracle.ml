open Util
module CD = Coverage.Domain
module F = Format
module L = Logger

(** [Validation] runs translation validation program (alive-tv).
    We use this program as an oracle to detect a miscompilation. *)
module Validator = struct
  type res_t = Correct | Incorrect | Failed | Errors

  let run src optimized =
    if Sys.file_exists src && Sys.file_exists optimized then
      let tv_process =
        Unix.open_process_args_in !Config.alive_tv_bin
          [| !Config.alive_tv_bin; src; optimized |]
      in
      let text = In_channel.input_all tv_process in
      (*AUtil.log "%s@." text;*)
      let status = Unix.close_process_in tv_process in
      match status with
      | Unix.WEXITED 0 -> (
          let lines =
            text
            |> String.split_on_char '\n'
            |> List.rev
            |> List.to_seq
            |> Seq.take 5
            |> List.of_seq
            |> List.rev
          in
          let eq_line line x =
            line
            |> String.trim
            |> String.split_on_char ' '
            |> List.hd
            |> int_of_string
            = x
          in
          match lines with
          | correct :: incorrect :: failed :: _errors ->
              if eq_line correct 1 then (
                L.info "Validator: %s refines %s"
                  (Filename.basename optimized)
                  (Filename.basename src);
                Correct)
              else if eq_line incorrect 1 then (
                L.info "Validator: %s does not refine %s"
                  (Filename.basename optimized)
                  (Filename.basename src);
                Incorrect)
              else if eq_line failed 1 then (
                L.info "Validator: failed to validate %s and %s"
                  (Filename.basename src)
                  (Filename.basename optimized);
                Failed)
              else (
                L.warn "Validator: exited with errors";
                Errors)
          | _ -> failwith "unexpected alive-tv output")
      | _ -> Errors
    else (
      L.warn "Validator: %s or %s are not found" src optimized;
      Errors)
end

let optimizer_passes =
  [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ]

(** [Optimizer] runs LLVM optimizer binary for specified passes and input IR.
    The input can be a file or LLVM module. *)
module Optimizer = struct
  type res_t = VALID of CD.Coverage.t | (* TODO: clearify *) INVALID | CRASH

  let run ~passes ?output filename =
    let passes = "--passes=\"" ^ String.concat "," passes ^ "\"" in
    let output = Option.fold ~none:"/dev/null" ~some:Fun.id output in
    L.info "opt: %s -> %s"
      (Filename.basename filename)
      (Filename.basename output);
    AUtil.clean !Config.cov_file;
    let exit_state =
      AUtil.cmd [ !Config.opt_bin; filename; "-S"; passes; "-o"; output ]
    in
    try
      let cov = CD.Coverage.read !Config.cov_file in
      if exit_state = 0 then VALID cov else CRASH
    with Sys_error _ ->
      (* cov.cov is not generated : the file did not trigger [passes] *)
      (* prerr_endline "Optimizer: cov.cov is not generated"; *)
      INVALID

  let run_for_llm ~passes llset llm =
    match ALlvm.LLModuleSet.get_new_name llset llm with
    | None -> INVALID
    | Some filename ->
        (* transform input into a file for the optimizer *)
        ALlvm.save_ll !Config.out_dir filename llm;
        let input = Filename.concat !Config.out_dir filename in
        let result = run ~passes input in
        AUtil.clean input;
        result
end
