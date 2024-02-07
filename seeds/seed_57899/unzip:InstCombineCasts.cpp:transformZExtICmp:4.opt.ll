; ModuleID = 'seeds/seed_57899/unzip:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/unzip:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @flush(ptr %0, i32 %1) {
entry:
  %and = and i32 %1, 1
  store i32 %and, ptr %0, align 8
  ret i32 0
}
