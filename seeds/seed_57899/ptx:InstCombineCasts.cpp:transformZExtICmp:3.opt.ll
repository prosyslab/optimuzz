; ModuleID = 'seeds/seed_57899/ptx:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/ptx:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_re_compile_fastmap() {
entry:
  call void @re_compile_fastmap_iter(ptr null, i8 0)
  ret i32 0
}

define internal void @re_compile_fastmap_iter(ptr %icase, i8 %0) {
entry:
  %1 = and i8 %0, 1
  store i8 %1, ptr %icase, align 1
  ret void
}
