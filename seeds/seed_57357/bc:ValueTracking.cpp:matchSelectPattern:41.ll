target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @execute(ptr %functions, i1 %cmp, i1 %tobool2) {
entry:
  %0 = select i1 %cmp, i1 %tobool2, i1 false
  br i1 %0, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret void

while.body:                                       ; preds = %entry
  store i8 0, ptr %functions, align 1
  br label %common.ret
}
