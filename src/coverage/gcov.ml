open Domain
module F = Format

let cmd = Util.LUtil.command_args

let clean () =
  cmd
    [
      "find";
      !Config.opt_bin |> Filename.dirname |> Filename.dirname;
      "-type f -name '*.gcda'";
      "| xargs rm";
    ]
  |> ignore

let get_gcov () =
  (* For redirection, we should use Unix.create_process *)
  Unix.chdir !Config.gcov_dir;
  let devnull = Unix.openfile "/dev/null" [ Unix.O_WRONLY ] 0o644 in
  List.iter
    (fun elem ->
      let llvm_pid =
        Unix.create_process "gcov" [| "gcov"; elem |] Unix.stdin devnull devnull
      in
      Unix.waitpid [] llvm_pid |> ignore)
    !Config.gcda_list;
  Unix.chdir !Config.workspace

let get_line_coverage chunks =
  try chunks |> List.hd |> String.trim |> int_of_string with Failure _ -> -1

let run () =
  get_gcov ();
  let rec aux fp accu =
    match input_line fp with
    | line ->
        (* each line is the form of [COVERED_TIMES:LINE_NUM:CODE] *)
        let chunks = String.split_on_char ':' line in
        if get_line_coverage chunks > 0 then
          aux fp
            (LineSet.add
               (List.nth chunks 1 |> String.trim |> int_of_string)
               accu)
        else aux fp accu
    | exception End_of_file ->
        close_in fp;
        accu
  in
  List.fold_left
    (fun accu elem ->
      LineCoverage.add elem (aux (open_in elem) LineSet.empty) accu)
    LineCoverage.empty !Config.gcov_list
