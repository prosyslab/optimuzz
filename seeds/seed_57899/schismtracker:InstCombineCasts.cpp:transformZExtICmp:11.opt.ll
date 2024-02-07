; ModuleID = 'seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @handle_key() {
entry:
  %call121 = call i32 @handle_key_global(i32 0)
  ret void
}

define internal i32 @handle_key_global(i32 %0) {
entry:
  %cmp76 = icmp eq i32 %0, 0
  %cond = zext i1 %cmp76 to i32
  call void @minipop_slide(i32 %cond)
  ret i32 0
}

declare void @minipop_slide(i32)
