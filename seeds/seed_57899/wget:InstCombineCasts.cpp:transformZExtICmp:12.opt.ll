; ModuleID = 'seeds/seed_57899/wget:InstCombineCasts.cpp:transformZExtICmp:12.ll'
source_filename = "seeds/seed_57899/wget:InstCombineCasts.cpp:transformZExtICmp:12.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @c_strcasestr(i32 %call, i32 %call6, ptr %ok) {
entry:
  %cmp = icmp eq i32 %call, %call6
  %frombool = zext i1 %cmp to i8
  store i8 %frombool, ptr %ok, align 1
  ret ptr null
}
