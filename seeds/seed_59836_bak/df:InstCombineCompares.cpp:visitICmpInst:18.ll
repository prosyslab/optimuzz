target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_fcntl(...) {
entry:
  %call161 = call i32 @rpl_fcntl_DUPFD_CLOEXEC(ptr null, i32 0, i1 false)
  ret i32 0
}

define internal i32 @rpl_fcntl_DUPFD_CLOEXEC(ptr %result, i32 %0, i1 %cmp13) {
entry:
  %cmp12 = icmp sle i32 0, %0
  %or.cond = select i1 %cmp12, i1 %cmp13, i1 false
  br i1 %or.cond, label %if.then14, label %common.ret

common.ret:                                       ; preds = %if.then14, %entry
  ret i32 0

if.then14:                                        ; preds = %entry
  %1 = load i32, ptr %result, align 4
  br label %common.ret
}
