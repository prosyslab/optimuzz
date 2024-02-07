target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @bsd_sum_stream(i64 %0) {
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %1 = xor i64 %0, -1
  %cmp22 = icmp ult i64 %1, %0
  br i1 %cmp22, label %if.then24, label %while.body

if.then24:                                        ; preds = %while.body
  ret i32 0
}
