target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %allocated, i64 %0) {
entry:
  %cmp29 = icmp ugt i64 %0, 0
  br i1 %cmp29, label %cond.true30, label %common.ret

common.ret:                                       ; preds = %cond.true30, %entry
  ret ptr null

cond.true30:                                      ; preds = %entry
  %1 = load i64, ptr %allocated, align 8
  br label %common.ret
}
