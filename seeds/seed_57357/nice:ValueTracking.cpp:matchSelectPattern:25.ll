target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %tmp) {
entry:
  %0 = load i64, ptr %tmp, align 8
  %cmp45 = icmp slt i64 %0, 0
  %1 = load i64, ptr %tmp, align 8
  %cond = select i1 %cmp45, i64 %1, i64 0
  %cmp47 = icmp sgt i64 0, %cond
  br i1 %cmp47, label %common.ret, label %cond.false50

common.ret:                                       ; preds = %cond.false50, %entry
  ret i32 0

cond.false50:                                     ; preds = %entry
  %2 = load i64, ptr %tmp, align 8
  br label %common.ret
}
