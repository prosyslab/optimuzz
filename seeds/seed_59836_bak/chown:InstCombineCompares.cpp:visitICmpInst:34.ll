target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %argc.addr, i1 %tobool52) {
entry:
  %0 = load i32, ptr %argc.addr, align 4
  %cond53 = select i1 %tobool52, i32 0, i32 2
  %cmp54 = icmp slt i32 %0, %cond53
  br i1 %cmp54, label %if.then55, label %common.ret

common.ret:                                       ; preds = %if.then55, %entry
  ret i32 0

if.then55:                                        ; preds = %entry
  %1 = load i32, ptr %argc.addr, align 4
  br label %common.ret
}
