target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @retryable_socket_connect_error(ptr %err.addr) {
entry:
  %err.addr1 = alloca i32, align 4
  %0 = load i32, ptr %err.addr1, align 4
  %cmp = icmp eq i32 %0, 97
  %1 = load i32, ptr %err.addr1, align 4
  %cmp1 = icmp eq i32 %1, 96
  %or.cond = select i1 %cmp, i1 true, i1 %cmp1
  br i1 %or.cond, label %if.then, label %lor.lhs.false2

lor.lhs.false2:                                   ; preds = %entry
  %2 = load i32, ptr %err.addr, align 4
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false2, %entry
  ret i1 false
}
