open Oracle
module F = Format
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

let measure_coverage (module Metric : CD.METRIC) input direct ~passes () =
  let res = Optimizer.run ~passes input in
  let target = CD.Path.parse direct |> Option.get in
  passes |> List.iter (fun pass -> F.printf "Pass: %s@." pass);
  match res with
  | Optimizer.VALID pathset -> (
      F.printf "Total coverage: %d@." (CD.Cov.cardinal pathset);
      F.printf "Covers: %b@." (CD.Cov.cover_target target pathset);
      match Metric.score target pathset with
      | Real score -> F.printf "Score: %f@." score
      | Infinity -> F.printf "Score: N/A@.")
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
