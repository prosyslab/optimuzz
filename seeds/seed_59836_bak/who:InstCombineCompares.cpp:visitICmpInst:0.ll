target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %maxlen, i64 %0) {
entry:
  %cmp1862 = icmp ult i64 0, %0
  br i1 %cmp1862, label %land.lhs.true1864, label %common.ret

common.ret:                                       ; preds = %land.lhs.true1864, %entry
  ret ptr null

land.lhs.true1864:                                ; preds = %entry
  %1 = load ptr, ptr %maxlen, align 8
  br label %common.ret
}
