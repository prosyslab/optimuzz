target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call4, ptr %argc.addr) {
entry:
  %cmp5 = icmp eq i32 %call4, 0
  br i1 %cmp5, label %if.then6, label %common.ret

common.ret:                                       ; preds = %if.then6, %entry
  ret i32 0

if.then6:                                         ; preds = %entry
  %0 = load i32, ptr %argc.addr, align 4
  br label %common.ret
}
