; ModuleID = 'seeds/seed_57899/mknod:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/mknod:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fts_open(ptr %sp, i32 %0) {
entry:
  %and49 = lshr i32 %0, 10
  %1 = trunc i32 %and49 to i8
  %2 = and i8 %1, 1
  store i8 %2, ptr %sp, align 1
  ret ptr null
}
