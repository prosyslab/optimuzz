target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %c, i32 %0) {
entry:
  %cond = icmp eq i32 %0, 0
  br i1 %cond, label %common.ret, label %sw.bb

common.ret:                                       ; preds = %sw.bb, %entry
  ret i32 0

sw.bb:                                            ; preds = %entry
  %1 = load i32, ptr %c, align 4
  br label %common.ret
}
