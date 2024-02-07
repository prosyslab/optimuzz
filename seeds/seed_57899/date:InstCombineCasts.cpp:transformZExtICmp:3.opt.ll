; ModuleID = 'seeds/seed_57899/date:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/date:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal(ptr %isdst, i32 %0) {
entry:
  %cmp62 = icmp eq i32 %0, 0
  %conv63 = zext i1 %cmp62 to i32
  store i32 %conv63, ptr %isdst, align 4
  ret i64 0
}
