; ModuleID = 'seeds/seed_57899/date:InstCombineCasts.cpp:transformZExtICmp:1.ll'
source_filename = "seeds/seed_57899/date:InstCombineCasts.cpp:transformZExtICmp:1.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal(ptr %mon_remainder, i32 %0) {
entry:
  %.lobit = lshr i32 %0, 31
  store i32 %.lobit, ptr %mon_remainder, align 4
  ret i64 0
}
