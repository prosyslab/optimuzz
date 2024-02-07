target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %allocated, i64 %0) {
entry:
  %cmp31 = icmp ule i64 %0, 9223372036854775807
  br i1 %cmp31, label %cond.true32, label %common.ret

common.ret:                                       ; preds = %cond.true32, %entry
  ret ptr null

cond.true32:                                      ; preds = %entry
  %1 = load i64, ptr %allocated, align 8
  br label %common.ret
}
