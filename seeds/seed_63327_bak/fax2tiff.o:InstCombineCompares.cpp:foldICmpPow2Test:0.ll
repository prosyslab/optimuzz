target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @copyFaxFile(ptr %xsize, i32 %0) {
entry:
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret i32 0

cond.true:                                        ; preds = %entry
  %1 = load i32, ptr %xsize, align 4
  br label %common.ret
}
