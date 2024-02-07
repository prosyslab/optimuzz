; ModuleID = 'seeds/seed_57899/cp:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/cp:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @backupfile_internal(i32 %0) {
entry:
  %cmp40 = icmp ne i32 %0, 0
  %cond41 = zext i1 %cmp40 to i32
  %call44 = call i32 @renameatu(i32 %cond41)
  ret ptr null
}

declare i32 @renameatu(i32)
