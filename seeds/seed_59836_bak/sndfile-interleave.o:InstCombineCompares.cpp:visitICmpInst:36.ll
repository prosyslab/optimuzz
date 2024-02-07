target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %0) {
entry:
  %cmp15 = icmp eq ptr %0, null
  br i1 %cmp15, label %if.then16, label %common.ret

common.ret:                                       ; preds = %if.then16, %entry
  ret i32 0

if.then16:                                        ; preds = %entry
  %call17 = call i32 @puts()
  br label %common.ret
}

declare i32 @puts()
