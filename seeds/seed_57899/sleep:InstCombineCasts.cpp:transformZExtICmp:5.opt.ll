; ModuleID = 'seeds/seed_57899/sleep:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/sleep:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @quotearg_buffer() {
cond.end:
  %call11 = call i64 @quotearg_buffer_restyled(ptr null, i32 0)
  ret i64 0
}

define internal i64 @quotearg_buffer_restyled(ptr %flags.addr, i32 %0) {
entry:
  %1 = trunc i32 %0 to i8
  %2 = lshr i8 %1, 1
  %3 = and i8 %2, 1
  store i8 %3, ptr %flags.addr, align 1
  ret i64 0
}
