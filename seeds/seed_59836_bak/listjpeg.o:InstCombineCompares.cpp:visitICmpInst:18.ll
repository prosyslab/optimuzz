target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printJpegStream(i32 %0, i1 %cmp26) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp25 = icmp ne i32 %0, 0
  %or.cond = select i1 %cmp25, i1 %cmp26, i1 false
  br i1 %or.cond, label %if.then27, label %while.cond

if.then27:                                        ; preds = %while.cond
  ret void
}
