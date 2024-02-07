target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call4) {
entry:
  %cmp5.not = icmp eq i32 %call4, 0
  br i1 %cmp5.not, label %common.ret, label %if.then6

common.ret:                                       ; preds = %if.then6, %entry
  ret i32 0

if.then6:                                         ; preds = %entry
  %call7 = call i32 @puts()
  br label %common.ret
}

declare i32 @puts()
