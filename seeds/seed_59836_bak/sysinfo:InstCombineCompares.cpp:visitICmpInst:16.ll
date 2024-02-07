target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @yypop_buffer_state(ptr %yy_buffer_stack_top, i64 %0) {
entry:
  %cmp = icmp ugt i64 %0, 0
  br i1 %cmp, label %if.then7, label %if.end8

if.then7:                                         ; preds = %entry
  %1 = load i64, ptr %yy_buffer_stack_top, align 8
  br label %if.end8

if.end8:                                          ; preds = %if.then7, %entry
  ret void
}
