target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@rpl_fcntl_DUPFD_CLOEXEC.have_dupfd_cloexec = external dso_local global i32

define i32 @rpl_fcntl(...) {
entry:
  ret i32 0

sw.bb2:                                           ; No predecessors!
  %call161 = call i32 @rpl_fcntl_DUPFD_CLOEXEC(ptr null, i32 0, ptr null, i32 0, i1 false)
  ret i32 0
}

define internal i32 @rpl_fcntl_DUPFD_CLOEXEC(ptr %result, i32 %0, ptr %rpl_fcntl_DUPFD_CLOEXEC.have_dupfd_cloexec, i32 %1, i1 %cmp13) {
entry:
  %result1 = alloca i32, align 4
  %2 = load i32, ptr %result, align 4
  %cmp12 = icmp sle i32 0, %0
  %3 = load i32, ptr %result, align 4
  %cmp132 = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp12, i1 %cmp13, i1 false
  br i1 %or.cond, label %if.then14, label %if.end25

if.then14:                                        ; preds = %entry
  %4 = load i32, ptr %result, align 4
  br label %if.end25

if.end25:                                         ; preds = %if.then14, %entry
  ret i32 0
}
