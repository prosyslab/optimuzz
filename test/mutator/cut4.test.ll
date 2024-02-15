; ModuleID = 'seeds/seed_62401/schismtracker:InstCombineMulDivRem.cpp:visitURem:8.ll'
source_filename = "seeds/seed_62401/schismtracker:InstCombineMulDivRem.cpp:visitURem:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @0(ptr %val0, i32 %val1, i32 %0, i32 %1) {
entry:
  %val2 = add i32 %val1, 1
  %val3 = urem i32 %val2, 6
  store i32 %val3, ptr %val0, align 4
  ret i32 %val3
}
