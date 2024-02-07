target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i8 @bc_is_zero(i8 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %conv = zext i8 %0 to i32
  %cmp2 = icmp eq i32 %conv, 0
  br i1 %cmp2, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i8 0
}
