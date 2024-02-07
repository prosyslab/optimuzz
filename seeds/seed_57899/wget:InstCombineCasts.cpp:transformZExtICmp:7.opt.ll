; ModuleID = 'seeds/seed_57899/wget:InstCombineCasts.cpp:transformZExtICmp:7.ll'
source_filename = "seeds/seed_57899/wget:InstCombineCasts.cpp:transformZExtICmp:7.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @lookup_host(ptr %0, i8 %1) {
entry:
  %2 = and i8 %1, 1
  store i8 %2, ptr %0, align 1
  ret ptr null
}
