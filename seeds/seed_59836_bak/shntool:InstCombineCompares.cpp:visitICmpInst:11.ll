target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @trim(i32 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp = icmp sge i32 %0, 0
  br i1 %cmp, label %land.rhs, label %while.cond

land.rhs:                                         ; preds = %while.cond
  ret void
}
