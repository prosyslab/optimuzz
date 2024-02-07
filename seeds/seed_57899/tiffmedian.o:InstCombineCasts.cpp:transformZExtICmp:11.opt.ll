; ModuleID = 'seeds/seed_57899/tiffmedian.o:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/tiffmedian.o:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @quant_fsdither(ptr null, i32 0)
  ret i32 0
}

define internal void @quant_fsdither(ptr %jmax, i32 %0) {
entry:
  %cmp60 = icmp eq i32 %0, 0
  %conv61 = zext i1 %cmp60 to i32
  store i32 %conv61, ptr %jmax, align 4
  ret void
}
