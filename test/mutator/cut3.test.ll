; ModuleID = 'seeds/seed_62401/who:InstCombineMulDivRem.cpp:visitURem:3.ll'
source_filename = "seeds/seed_62401/who:InstCombineMulDivRem.cpp:visitURem:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @0(ptr %0, i8 %1, i64 %2, i64 %3) {
entry:
  %val2 = zext i8 %1 to i64
  ret i64 %val2
}
