target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @set_process_security_ctx(i32 %call, ptr %con) {
entry:
  %cmp = icmp sle i32 0, %call
  br i1 %cmp, label %if.then7, label %common.ret

common.ret:                                       ; preds = %if.then7, %entry
  ret i1 false

if.then7:                                         ; preds = %entry
  %0 = load ptr, ptr %con, align 8
  br label %common.ret
}
