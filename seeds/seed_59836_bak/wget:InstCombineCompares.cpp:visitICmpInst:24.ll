target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ftp_list(ptr %i, i64 %0) {
entry:
  %inc = add i64 %0, 1
  %cmp38 = icmp eq i64 %inc, 1
  br i1 %cmp38, label %if.then40, label %common.ret

common.ret:                                       ; preds = %if.then40, %entry
  ret i32 0

if.then40:                                        ; preds = %entry
  %1 = load i64, ptr %i, align 8
  br label %common.ret
}
