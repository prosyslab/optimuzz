; ModuleID = 'seeds/seed_57899/env:InstCombineCasts.cpp:transformZExtICmp:6.ll'
source_filename = "seeds/seed_57899/env:InstCombineCasts.cpp:transformZExtICmp:6.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @parse_split_string()
  ret i32 0
}

define internal void @parse_split_string() {
entry:
  %call1 = call ptr @build_argv(ptr null, i8 0)
  ret void
}

define internal ptr @build_argv(ptr %sq, i8 %0) {
entry:
  %1 = and i8 %0, 1
  %2 = xor i8 %1, 1
  store i8 %2, ptr %sq, align 1
  ret ptr null
}
