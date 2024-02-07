; ModuleID = 'seeds/seed_57899/chcon:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/chcon:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @i_ring_push(ptr %ir.addr, i8 %0) {
entry:
  %1 = and i8 %0, 1
  %2 = zext i8 %1 to i32
  store i32 %2, ptr %ir.addr, align 4
  ret i32 0
}
