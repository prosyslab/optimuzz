; ModuleID = 'seeds/seed_57899/unzip:InstCombineCasts.cpp:transformZExtICmp:6.ll'
source_filename = "seeds/seed_57899/unzip:InstCombineCasts.cpp:transformZExtICmp:6.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @mapattr(ptr %tmp, i64 %0) {
entry:
  %1 = and i64 %0, 1
  %2 = xor i64 %1, 1
  store i64 %2, ptr %tmp, align 8
  ret i32 0
}
