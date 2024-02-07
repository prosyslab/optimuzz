target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @fnfilter(ptr %s, ptr %0) {
entry:
  %.pre = load ptr, ptr %s, align 8
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %add.ptr44 = getelementptr i8, ptr %0, i64 -3
  %cmp45 = icmp ugt ptr %.pre, %add.ptr44
  br i1 %cmp45, label %if.then47, label %while.cond

if.then47:                                        ; preds = %while.cond
  ret ptr null
}
