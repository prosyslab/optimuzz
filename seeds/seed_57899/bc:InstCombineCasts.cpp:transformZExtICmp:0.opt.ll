; ModuleID = 'seeds/seed_57899/bc:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/bc:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @bc_sub(ptr %n2.addr, i32 %0) {
entry:
  %cmp7 = icmp eq i32 %0, 0
  %cond = zext i1 %cmp7 to i32
  store i32 %cond, ptr %n2.addr, align 8
  ret void
}
