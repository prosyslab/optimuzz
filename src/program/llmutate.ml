open Util
module L = Logger

type mode = Rand | Exact of Mutation.Domain.mutation_t

let bound = ref 10 (* number of retries to find a proper mutation *)
let mode = ref Rand
let focus = ref true

let opts =
  [
    ("-no-focus", Arg.Clear focus, "disable focusing on important instructions");
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
  assert (Sys.file_exists path);
  assert (Sys.file_exists save_dir);
  assert (Sys.is_directory save_dir);

  let llctx = Llvm.create_context () in
  Config.Interests.set_interesting_types llctx;
  let importants_filename = "importants" in
  match ALlvm.read_ll llctx path with
  | Ok llm -> (
      let importants =
        if !focus && Sys.file_exists importants_filename then
          In_channel.with_open_text importants_filename In_channel.input_all
          |> String.split_on_char '\n'
        else []
      in
      print_endline "llm:";
      print_endline (ALlvm.string_of_llmodule llm);
      let mutated_instrs, mutant =
        Mutation.Mutator.run ~times:!bound llctx llm importants choice
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

  let args = ref [] in
  Arg.parse opts
    (fun s -> args := s :: !args)
    "Usage: llmutate <filename> <save_dir> <save_name> <importants>";
  args := List.rev !args;
  match !args with
  | [ filename; save_dir; save_name ] ->
      L.from_file "llmutate.log";
      L.set_level L.DEBUG;

      main filename save_dir save_name |> print_endline
  | _ -> failwith "invalid arguments"
