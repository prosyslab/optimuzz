target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @connect_to_ip(ptr %0, i8 %1, i1 %cmp36) {
entry:
  %tobool33 = trunc i8 %1 to i1
  %or.cond = select i1 %tobool33, i1 %cmp36, i1 false
  br i1 %or.cond, label %if.then38, label %common.ret

common.ret:                                       ; preds = %if.then38, %entry
  ret i32 0

if.then38:                                        ; preds = %entry
  %2 = load i8, ptr %0, align 1
  br label %common.ret
}
