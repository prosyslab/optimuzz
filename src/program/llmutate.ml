open Util
module L = Logger

type mode = Rand | Exact of Mutation.Domain.mutation_t

let bound = ref 5 (* number of retries to find a proper mutation *)
let mode = ref Rand

let opts =
  [
    ("-bound", Arg.Set_int bound, "number of retries to find a proper mutation");
    ( "-mode",
      Arg.String (fun s -> mode := Exact (Mutation.Domain.mutation_of_string s)),
      "mutation mode" );
  ]

let choice () =
  let muts = Mutation.Domain.uniform_mutations in
  let idx = Random.int (Array.length muts) in
  muts.(idx)

let main path save_dir save_name =
  let llctx = Llvm.create_context () in
  Config.Interests.set_interesting_types llctx;
  match ALlvm.read_ll llctx path with
  | Ok llm -> (
      let _, _, mutant = Mutation.Mutator.run ~times:10 llctx llm choice in
      match mutant with
      | None -> failwith "Failed to find a proper mutation"
      | Some mutant ->
          let save_path = ALlvm.save_ll save_dir save_name mutant in
          save_path)
  | Error e -> failwith e

let _ =
  Printexc.record_backtrace true;
  Random.self_init ();
  if Array.length Sys.argv < 4 then (
    Format.eprintf "Usage: llmutate <filename> <save_dir> <save_name>";
    exit 0);

  Arg.parse opts (fun _ -> ()) "";

  L.from_channel stdout;
  L.set_level L.DEBUG;

  let filename = Sys.argv.(1) in
  let save_dir = Sys.argv.(2) in
  let save_name = Sys.argv.(3) |> Filename.basename in
  let save_path = main filename save_dir save_name in
  print_endline save_path
