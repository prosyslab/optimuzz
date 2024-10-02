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

let save_mutated_instrs filename mutated_instrs =
  Out_channel.with_open_text filename (fun instr ->
      List.iter (Printf.fprintf instr "%s\n") mutated_instrs)

let main path save_dir save_name =
  let llctx = Llvm.create_context () in
  Config.Interests.set_interesting_types llctx;
  let importants_filename = "importants" in
  match ALlvm.read_ll llctx path with
  | Ok llm -> (
      let importants =
        if Sys.file_exists importants_filename then
          In_channel.with_open_text importants_filename In_channel.input_all
          |> String.split_on_char '\n'
        else []
      in
      print_endline "llm:";
      print_endline (ALlvm.string_of_llmodule llm);
      let mutated_instrs, mutant =
        (* Mutation.Mutator.run ~times:10 llctx llm importants choice *)
        Mutation.Mutator.run ~times:10 llctx llm importants choice
      in

      match mutant with
      | None -> failwith "Failed to find a proper mutation"
      | Some mutant ->
          let mutated_path =
            Filename.concat save_dir
              (Filename.chop_suffix save_name ".mut.ll" ^ ".mutated")
          in
          let save_path = ALlvm.save_ll save_dir save_name mutant in
          save_mutated_instrs mutated_path mutated_instrs;
          save_path)
  | Error e -> failwith e

let _ =
  Printexc.record_backtrace true;
  Random.self_init ();
  if Array.length Sys.argv < 4 then (
    Format.eprintf
      "Usage: llmutate <filename> <save_dir> <save_name> <importants>";
    exit 0);

  Arg.parse opts (fun _ -> ()) "";

  L.from_file "llmutate.log";
  L.set_level L.DEBUG;

  let filename = Sys.argv.(1) in
  let save_dir = Sys.argv.(2) in
  let save_name = Sys.argv.(3) |> Filename.basename in
  let save_path = main filename save_dir save_name in
  print_endline save_path
