; ModuleID = 'seeds/seed_57899/b2sum:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/b2sum:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @blake2b_final() {
entry:
  %call1 = call i32 @blake2b_is_lastblock(i64 0)
  ret i32 0
}

define internal i32 @blake2b_is_lastblock(i64 %0) {
entry:
  %cmp = icmp ne i64 %0, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}
