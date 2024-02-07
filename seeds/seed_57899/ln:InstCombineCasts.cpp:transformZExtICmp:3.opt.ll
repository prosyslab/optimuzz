; ModuleID = 'seeds/seed_57899/ln:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/ln:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

define ptr @mdir_name(i8 %0) {
entry:
  %1 = and i8 %0, 1
  %2 = zext i8 %1 to i64
  %call2 = call ptr @malloc(i64 %2)
  ret ptr null
}
