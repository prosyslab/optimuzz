target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i8 @yna(ptr %key, i32 %0) {
entry:
  %cmp6 = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp6, i1 false, i1 true
  br i1 %or.cond, label %if.then8, label %common.ret

common.ret:                                       ; preds = %if.then8, %entry
  ret i8 0

if.then8:                                         ; preds = %entry
  %1 = load i8, ptr %key, align 1
  br label %common.ret
}
