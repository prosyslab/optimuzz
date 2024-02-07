target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @count_leading_zeros_ll(ptr %x.addr, i64 %0) {
entry:
  %tobool = icmp ne i64 %0, 0
  br i1 %tobool, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i64, ptr %x.addr, align 8
  br label %cond.false

cond.false:                                       ; preds = %cond.true, %entry
  ret i32 0
}
