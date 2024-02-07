; ModuleID = 'seeds/seed_57899/expand:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/expand:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @close_stream(i32 %call1, ptr %prev_fail) {
entry:
  %cmp2 = icmp ne i32 %call1, 0
  %frombool3 = zext i1 %cmp2 to i8
  store i8 %frombool3, ptr %prev_fail, align 1
  ret i32 0
}
