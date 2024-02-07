; ModuleID = 'seeds/seed_57899/tr:InstCombineCasts.cpp:transformZExtICmp:6.ll'
source_filename = "seeds/seed_57899/tr:InstCombineCasts.cpp:transformZExtICmp:6.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %delete, i8 %0) {
entry:
  %1 = and i8 %0, 1
  %2 = xor i8 %1, 1
  store i8 %2, ptr %delete, align 1
  ret i32 0
}
