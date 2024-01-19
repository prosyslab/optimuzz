let _ =
  let llctx = Llvm.create_context () in
  let buf = Llvm.MemoryBuffer.of_file Sys.argv.(1) in
  let llm = Llvm_irreader.parse_ir llctx buf in
  let mutant = Fuzz.Mutator.run llctx Fuzz.Mutator.FOCUS llm 10 in

  Llvm.string_of_llmodule mutant |> print_endline
