; ModuleID = 'seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @handle_key() {
entry:
  %call121 = call i32 @handle_key_global(ptr null, i32 0)
  ret void
}

define internal i32 @handle_key_global(ptr %i, i32 %0) {
entry:
  %cmp183.not = icmp ne i32 %0, 0
  %cond184 = zext i1 %cmp183.not to i32
  store i32 %cond184, ptr %i, align 4
  ret i32 0
}
