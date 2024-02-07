; ModuleID = 'seeds/seed_57899/tiffdither.o:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/tiffdither.o:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call1261 = call i32 @fsdither(ptr null, i32 0)
  ret i32 0
}

define internal i32 @fsdither(ptr %jmax, i32 %0) {
entry:
  %cmp63 = icmp eq i32 %0, 0
  %conv64 = zext i1 %cmp63 to i32
  store i32 %conv64, ptr %jmax, align 4
  ret i32 0
}
