; ModuleID = 'seeds/seed_57899/chmod:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/chmod:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %mode_len, i64 %0) {
entry:
  %tobool = icmp ne i64 %0, 0
  %conv = zext i1 %tobool to i64
  store i64 %conv, ptr %mode_len, align 8
  ret i32 0
}
