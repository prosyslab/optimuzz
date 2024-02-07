target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @findPage(i32 %conv1) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp = icmp ne i32 0, %conv1
  br i1 %cmp, label %land.lhs.true, label %while.cond

land.lhs.true:                                    ; preds = %while.cond
  ret i32 0
}
