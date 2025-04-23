  $ mkdir muts
  $ llmutate seed.ll muts seed.mut.ll 2> /dev/null | grep "define.*f"
  define i64 @f(i32 %x) {
