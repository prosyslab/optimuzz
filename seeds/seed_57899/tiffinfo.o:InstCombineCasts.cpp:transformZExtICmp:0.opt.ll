; ModuleID = 'seeds/seed_57899/tiffinfo.o:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/tiffinfo.o:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %argc.addr, i32 %0) {
entry:
  %cmp34 = icmp sgt i32 %0, 0
  %conv = zext i1 %cmp34 to i32
  store i32 %conv, ptr %argc.addr, align 4
  ret i32 0
}
