; ModuleID = 'seeds/seed_62401/pr:InstCombineMulDivRem.cpp:visitURem:4.ll'
source_filename = "seeds/seed_62401/pr:InstCombineMulDivRem.cpp:visitURem:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @set_char_quoting(ptr %uc, i64 %conv1) {
entry:
  %0 = trunc i64 %conv1 to i32
  %conv2 = and i32 %0, 31
  store i32 %conv2, ptr %uc, align 4
  ret i32 0
}
