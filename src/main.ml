module F = Format

let usage = "Usage: generator [size of program] [number of examples]"

let main argv =
  if Array.length argv <> 3 then (
    prerr_endline "generator: You must specify two integers";
    prerr_endline usage;
    exit 1 );
  Random.self_init ();
  let pgm = Generator.generate_program (int_of_string argv.(1)) in
  F.eprintf "Synthesized Program: %a\n" Language.pp pgm;
  Generator.generate_example pgm (int_of_string argv.(2))

let _ = main Sys.argv
