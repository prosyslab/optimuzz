open Oracle
module F = Format

let input_file = ref ""
let direct = ref ""
let passes = ref []
let mtriple = ref ""

let speclist =
  [
    ("-direct", Arg.Set_string direct, "Path to the coverage target");
    ( "-passes",
      Arg.String (fun s -> passes := String.split_on_char ',' s),
      "Comma separated list of passes" );
    ( "-mtriple",
      Arg.String (fun s -> mtriple := s),
      "Comma separated list of passes" );
  ]

let measure_coverage input direct ~passes ~mtriple () =
  let module Opt = Optimizer in
  let res = Opt.run ~passes ~mtriple input in
  let target = CD.Path.parse direct |> Option.get in
  passes |> List.iter (fun pass -> F.printf "Pass: %s@." pass);
  match res with
  | Ok lines ->
      let cov = CD.AstCoverage.of_lines lines in
      F.printf "Total coverage: %d@." (CD.AstCoverage.cardinal cov);
      F.printf "Covers: %b@." (CD.AstCoverage.cover_target target cov);
      ()
  | _ -> ()

let _ =
  Arg.parse speclist
    (fun s -> input_file := s)
    "Usage: measure_coverage <filename> -direct <path> -passes \
     <pass1,pass2,...> -mtriple <mtriple>";

  if !passes = [] then passes := [ "instcombine" ];

  L.from_file "cov.log";

  measure_coverage !input_file !direct ~passes:!passes ~mtriple:!mtriple ()
