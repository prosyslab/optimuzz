target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sfe_copy_data_int(i32 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp = icmp sgt i32 %0, 0
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret void
}
