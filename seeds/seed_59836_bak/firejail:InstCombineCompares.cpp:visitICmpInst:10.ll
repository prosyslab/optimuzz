target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @pin_sandbox_process() {
entry:
  call void @check_joinable(i1 false, ptr null)
  ret ptr null
}

define internal void @check_joinable(i1 %call, ptr %i) {
entry:
  %conv = zext i1 %call to i32
  %cmp = icmp eq i32 %conv, 0
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %0 = load i64, ptr %i, align 8
  br label %common.ret
}
