open Oracle
module F = Format
module Path = Coverage.Path
module CD = Coverage.Domain

let input_file = ref ""
let direct = ref ""
let passes = ref []
let metric = ref "avg"

let speclist =
  [
    ("-direct", Arg.Set_string direct, "Path to the coverage target");
    ( "-passes",
      Arg.String (fun s -> passes := String.split_on_char ',' s),
      "Comma separated list of passes" );
    ("-metric", Arg.Set_string metric, "Metric to use (avg, min)");
  ]

let measure_coverage (module Cov : CD.COVERAGE) input direct ~passes () =
  let module Optimizer = Optimizer (Cov) in
  let res = Optimizer.run ~passes input in
  let target = Path.parse direct |> Option.get in
  passes |> List.iter (fun pass -> F.printf "Pass: %s@." pass);
  match res with
  | Optimizer.VALID cov ->
      F.printf "Total coverage: %d@." (Cov.cardinal cov);
      F.printf "Covers: %b@." (Cov.cover_target target cov);
      ()
  | _ -> ()

let _ =
  Arg.parse speclist
    (fun s -> input_file := s)
    "Usage: measure_coverage <filename> -direct <path> -passes \
     <pass1,pass2,...>";

  if !passes = [] then passes := [ "instcombine" ];

  L.from_file "cov.log";

  match !metric with
  | "avg" ->
      measure_coverage
        (module Coverage.Avg_dist)
        !input_file !direct ~passes:!passes ()
  | "min" ->
      measure_coverage
        (module Coverage.Min_dist)
        !input_file !direct ~passes:!passes ()
  | _ -> failwith "Invalid metric"
