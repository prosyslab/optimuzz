; ModuleID = 'seeds/seed_57899/timeout:InstCombineCasts.cpp:transformZExtICmp:2.ll'
source_filename = "seeds/seed_57899/timeout:InstCombineCasts.cpp:transformZExtICmp:2.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @timespec_sign(i64 %0) {
entry:
  %.lobit = lshr i64 %0, 63
  %1 = trunc i64 %.lobit to i32
  ret i32 %1
}
