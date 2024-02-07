; ModuleID = 'seeds/seed_57899/shntool:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/shntool:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @close_and_wait(i32 %0) {
entry:
  %cmp35 = icmp eq i32 %0, 0
  %conv = zext i1 %cmp35 to i32
  call void (ptr, i32, ptr, ...) @st_snprintf(ptr null, i32 0, ptr null, i32 0, i32 %conv)
  ret i32 0
}

declare void @st_snprintf(ptr, i32, ptr, ...)
