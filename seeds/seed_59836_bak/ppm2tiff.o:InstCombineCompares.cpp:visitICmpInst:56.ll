target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  %cond = icmp eq i32 %0, 0
  br i1 %cond, label %sw.bb10, label %common.ret

common.ret:                                       ; preds = %sw.bb10, %entry
  ret i32 0

sw.bb10:                                          ; preds = %entry
  call void @usage()
  br label %common.ret
}

declare void @usage()
