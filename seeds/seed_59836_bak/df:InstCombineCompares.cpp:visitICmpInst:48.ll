target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @xsum(ptr %size2.addr, i64 %0, i64 %1) {
entry:
  %add = add i64 %1, %0
  %cmp = icmp uge i64 %add, %0
  br i1 %cmp, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret i64 0

cond.true:                                        ; preds = %entry
  %2 = load i64, ptr %size2.addr, align 8
  br label %common.ret
}
