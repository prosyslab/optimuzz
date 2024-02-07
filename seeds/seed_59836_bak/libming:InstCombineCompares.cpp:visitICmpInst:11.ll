target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @SWFMovie_toOutput(ptr %level.addr, i32 %0) {
entry:
  %cmp61 = icmp sge i32 %0, 0
  br i1 %cmp61, label %if.then63, label %common.ret

common.ret:                                       ; preds = %if.then63, %entry
  ret ptr null

if.then63:                                        ; preds = %entry
  %1 = load i32, ptr %level.addr, align 4
  br label %common.ret
}
