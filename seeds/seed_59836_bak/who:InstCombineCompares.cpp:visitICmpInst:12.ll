target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @xsum(ptr %sum, i64 %0) {
entry:
  %cmp = icmp uge i64 %0, 1
  br i1 %cmp, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret i64 0

cond.true:                                        ; preds = %entry
  %1 = load i64, ptr %sum, align 8
  br label %common.ret
}
