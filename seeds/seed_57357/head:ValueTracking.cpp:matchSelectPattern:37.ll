target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @xpalloc(i64 %0) {
entry:
  %cmp4 = icmp slt i64 %0, 0
  %cond = select i1 %cmp4, i32 1, i32 0
  %conv = sext i32 %cond to i64
  ret ptr null
}
