target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @check_zipfile(ptr %method, i32 %0, i1 %cmp48) {
entry:
  %cmp46 = icmp ne i32 %0, 0
  %or.cond = select i1 %cmp46, i1 %cmp48, i1 false
  br i1 %or.cond, label %if.then50, label %common.ret

common.ret:                                       ; preds = %if.then50, %entry
  ret i32 0

if.then50:                                        ; preds = %entry
  %1 = load ptr, ptr %method, align 8
  br label %common.ret
}
