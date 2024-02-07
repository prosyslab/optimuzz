; ModuleID = 'seeds/seed_57899/bc:InstCombineCasts.cpp:transformZExtICmp:12.ll'
source_filename = "seeds/seed_57899/bc:InstCombineCasts.cpp:transformZExtICmp:12.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @bc_multiply(ptr %n1.addr, i32 %0, i32 %1) {
entry:
  %cmp54 = icmp ne i32 %0, %1
  %cond55 = zext i1 %cmp54 to i32
  store i32 %cond55, ptr %n1.addr, align 8
  ret void
}
