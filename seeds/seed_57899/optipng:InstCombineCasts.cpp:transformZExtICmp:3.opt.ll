; ModuleID = 'seeds/seed_57899/optipng:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/optipng:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @deflate(ptr %s, i64 %0) {
entry:
  %cmp211.not = icmp eq i64 %0, 0
  %cond213 = zext i1 %cmp211.not to i32
  store i32 %cond213, ptr %s, align 4
  ret i32 0
}
