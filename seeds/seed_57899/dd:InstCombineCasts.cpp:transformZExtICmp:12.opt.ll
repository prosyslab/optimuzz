; ModuleID = 'seeds/seed_57899/dd:InstCombineCasts.cpp:transformZExtICmp:12.ll'
source_filename = "seeds/seed_57899/dd:InstCombineCasts.cpp:transformZExtICmp:12.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %r2110, i32 %0, i32 %1) {
entry:
  %cmp121 = icmp ne i32 %1, %0
  %conv122 = zext i1 %cmp121 to i32
  store i32 %conv122, ptr %r2110, align 4
  ret ptr null
}
