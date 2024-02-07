; ModuleID = 'seeds/seed_57899/csplit:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/csplit:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_re_compile_pattern() {
entry:
  %call = call i32 @re_compile_internal()
  ret ptr null
}

define internal i32 @re_compile_internal() {
entry:
  %call68 = call i32 @analyze()
  ret i32 0
}

define internal i32 @analyze() {
entry:
  %call77 = call i32 @calc_eclosure()
  ret i32 0
}

define internal i32 @calc_eclosure() {
entry:
  %call = call i32 @calc_eclosure_iter()
  ret i32 0
}

define internal i32 @calc_eclosure_iter() {
entry:
  %call30 = call i32 @duplicate_node_closure()
  ret i32 0
}

define internal i32 @duplicate_node_closure() {
entry:
  %call = call i64 @duplicate_node()
  ret i32 0
}

define internal i64 @duplicate_node() {
entry:
  %call1 = call i64 @re_dfa_add_node(ptr null, i32 0)
  ret i64 0
}

define internal i64 @re_dfa_add_node(ptr %token, i32 %bf.load72) {
entry:
  %cmp74 = icmp eq i32 %bf.load72, 0
  %lor.ext77 = zext i1 %cmp74 to i32
  store i32 %lor.ext77, ptr %token, align 8
  ret i64 0
}
