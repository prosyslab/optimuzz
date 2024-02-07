; ModuleID = 'seeds/seed_57899/lrzip:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/lrzip:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @open_tmpoutfile(i64 %0) {
entry:
  %and55 = lshr i64 %0, 19
  %1 = trunc i64 %and55 to i8
  %2 = and i8 %1, 1
  call void @register_outfile(i8 %2)
  ret i32 0
}

declare void @register_outfile(i8)
