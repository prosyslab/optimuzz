target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %0) {
entry:
  %tobool.not = icmp eq ptr %0, null
  br i1 %tobool.not, label %if.then5, label %common.ret

common.ret:                                       ; preds = %if.then5, %entry
  ret i32 0

if.then5:                                         ; preds = %entry
  %call6 = call i32 (...) @printf()
  br label %common.ret
}

declare i32 @printf(...)
