open Util
module CD = Coverage.Domain
module F = Format
module L = Logger

(** [Validation] runs translation validation program (alive-tv).
    We use this program as an oracle to detect a miscompilation. *)
module Validator = struct
  type res_t = Correct | Incorrect | Failed | Errors

  let run src optimized =
    if Sys.file_exists src && Sys.file_exists optimized then (
      (* let tv_process =
           Unix.open_process_args_in !Config.alive_tv_bin
             [| !Config.alive_tv_bin; src; optimized |]
         in *)
      let lines =
        List.fold_left
          (fun accu line ->
            if not (String.starts_with ~prefix:"target " line) then line :: accu
            else accu)
          []
          (AUtil.readlines optimized)
        |> List.rev
      in
      Out_channel.with_open_text optimized (fun instr ->
          List.iter (Printf.fprintf instr "%s\n") lines);
      let tv_process =
        Unix.open_process_args_in "timeout"
          [| "timeout"; "2m"; !Config.alive_tv_bin; src; optimized |]
      in
      let text = In_channel.input_all tv_process in
      print_endline text;
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
      | _ -> Errors)
    else (
      L.warn "Validator: %s or %s are not found" src optimized;
      Errors)
end

(** [Optimizer] runs LLVM opt for specified passes and input IR.
    The input is a file of LLVM Module (in IR). *)
module Optimizer = struct
  type err_t =
    (* coverage file (cov.cov) is not generated -- probably the LLVM version is not instrumented? *)
    | File_not_found
    (* optimizer exited with non-zero exit code *)
    | Non_zero_exit
    (* optimizer hangs -- timeout expired *)
    | Hang

  type res_t = Ok of string list | Assert of string list | Error of err_t

  let run ~passes ~mtriple ?output filename =
    let passes = "--passes=\"" ^ String.concat "," passes ^ "\"" in
    let mtriple =
      if mtriple = "" then "" else "--mtriple=\"" ^ mtriple ^ "\""
    in
    print_endline "mtriple:";
    print_endline mtriple;
    let output = Option.fold ~none:"/dev/null" ~some:Fun.id output in
    L.debug "opt: %s -> %s"
      (Filename.basename filename)
      (Filename.basename output);
    try
      AUtil.clean !Config.cov_file;
      let exit_state =
        AUtil.cmd
          [
            "timeout 5s";
            !Config.opt_bin;
            filename;
            (* "--mtriple=x86_64-unknown-linux-gnu"; *)
            "-S";
            passes;
            mtriple;
            "-o";
            output;
          ]
      in
      try
        let lines = AUtil.readlines !Config.cov_file in
        match exit_state with
        | 0 -> Ok lines
        | 134 -> Assert lines
        | _ -> Error Non_zero_exit
      with Sys_error _ ->
        (* cov.cov is not generated : the file did not trigger [passes] *)
        (* prerr_endline "Optimizer: cov.cov is not generated"; *)
        Error File_not_found
    with _ -> Error Non_zero_exit
end
