; ModuleID = 'seeds/seed_57899/png2dbl.o:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/png2dbl.o:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @writeDBL(ptr %png, i32 %0) {
entry:
  %cmp = icmp eq i32 %0, 0
  %lor.ext = zext i1 %cmp to i32
  store i32 %lor.ext, ptr %png, align 4
  ret void
}
