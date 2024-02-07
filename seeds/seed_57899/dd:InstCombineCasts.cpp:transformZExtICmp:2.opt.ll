; ModuleID = 'seeds/seed_57899/dd:InstCombineCasts.cpp:transformZExtICmp:2.ll'
source_filename = "seeds/seed_57899/dd:InstCombineCasts.cpp:transformZExtICmp:2.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @xtime_sec(i64 %0) {
entry:
  %.lobit = lshr i64 %0, 63
  ret i64 %.lobit
}
