target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @error_line(...)

define i32 @main(ptr %params, i1 %tobool296.not) {
entry:
  %0 = load i32, ptr %params, align 4
  %cond = select i1 %tobool296.not, i32 256, i32 0
  %cmp297 = icmp sgt i32 %0, %cond
  br i1 %cmp297, label %if.then299, label %common.ret

common.ret:                                       ; preds = %if.then299, %entry
  ret i32 0

if.then299:                                       ; preds = %entry
  call void (...) @error_line()
  br label %common.ret
}
