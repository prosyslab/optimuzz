target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @bsd_sum_stream(ptr %sum) {
entry:
  %.pre = load i64, ptr %sum, align 8
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %add21 = add i64 %.pre, 1
  %cmp22 = icmp ult i64 %add21, %.pre
  br i1 %cmp22, label %if.then24, label %while.body

if.then24:                                        ; preds = %while.body
  ret i32 0
}
