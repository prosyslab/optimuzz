; ModuleID = 'seeds/seed_57899/true:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/true:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %flags.addr, i32 %0) {
entry:
  %cmp1 = icmp ne i32 %0, 0
  %frombool2 = zext i1 %cmp1 to i8
  store i8 %frombool2, ptr %flags.addr, align 1
  ret i64 0
}

define ptr @quotearg_alloc_mem() {
cond.end:
  %call41 = call i64 @quotearg_buffer_restyled(ptr null, i32 0)
  ret ptr null
}
