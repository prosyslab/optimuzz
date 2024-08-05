open Util

let choice () =
  let muts = Mutation.Domain.uniform_mutations in
  let idx = Random.int (Array.length muts) in
  muts.(idx)

let main path save_dir save_name =
  let llctx = Llvm.create_context () in
  match ALlvm.read_ll llctx path with
  | Ok llm -> (
      let _, _, mutant = Mutation.Mutator.run llctx llm choice in
      match mutant with
      | None -> failwith "Failed to find a proper mutation"
      | Some mutant ->
          let save_path = ALlvm.save_ll save_dir save_name mutant in
          save_path)
  | Error e -> failwith e

let _ =
  let path = Sys.argv.(1) in
  let save_dir = Sys.argv.(2) in
  let save_name = Sys.argv.(3) in
  let save_path = main path save_dir save_name in
  print_endline save_path
