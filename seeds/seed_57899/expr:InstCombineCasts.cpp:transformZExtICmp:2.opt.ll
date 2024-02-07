; ModuleID = 'seeds/seed_57899/expr:InstCombineCasts.cpp:transformZExtICmp:2.ll'
source_filename = "seeds/seed_57899/expr:InstCombineCasts.cpp:transformZExtICmp:2.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call11 = call ptr @eval()
  ret i32 0
}

define internal ptr @eval() {
entry:
  %call = call ptr @eval1()
  ret ptr null
}

define internal ptr @eval1() {
entry:
  %call1 = call ptr @eval2(ptr null, i32 0)
  ret ptr null
}

define internal ptr @eval2(ptr %cmp, i32 %0) {
entry:
  %.lobit = lshr i32 %0, 31
  %1 = trunc i32 %.lobit to i8
  store i8 %1, ptr %cmp, align 1
  ret ptr null
}
