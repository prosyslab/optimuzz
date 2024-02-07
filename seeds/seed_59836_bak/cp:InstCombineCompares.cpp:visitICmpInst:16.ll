target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @full_write(ptr %count.addr, i64 %0) {
entry:
  %cmp = icmp ugt i64 %0, 0
  br i1 %cmp, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret i64 0

while.body:                                       ; preds = %entry
  %1 = load i32, ptr %count.addr, align 4
  br label %common.ret
}
