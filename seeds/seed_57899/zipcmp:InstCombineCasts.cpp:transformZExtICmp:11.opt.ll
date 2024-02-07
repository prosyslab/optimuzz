; ModuleID = 'seeds/seed_57899/zipcmp:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/zipcmp:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call16) {
entry:
  %cmp17 = icmp ne i32 %call16, 0
  %cond = zext i1 %cmp17 to i32
  call void @exit(i32 %cond)
  unreachable
}

declare void @exit(i32)
