target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_fcntl(...) {
entry:
  %call161 = call i32 @rpl_fcntl_DUPFD_CLOEXEC(ptr null, i32 0)
  ret i32 0
}

define internal i32 @rpl_fcntl_DUPFD_CLOEXEC(ptr %rpl_fcntl_DUPFD_CLOEXEC.have_dupfd_cloexec, i32 %0) {
entry:
  %cmp = icmp sle i32 0, %0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %rpl_fcntl_DUPFD_CLOEXEC.have_dupfd_cloexec, align 4
  br label %common.ret
}
