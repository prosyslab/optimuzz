target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %fsize, i64 %0) {
entry:
  %cmp485 = icmp ugt i64 %0, 0
  %or.cond1 = select i1 %cmp485, i1 false, i1 true
  br i1 %or.cond1, label %if.then493, label %common.ret

common.ret:                                       ; preds = %if.then493, %entry
  ret i32 0

if.then493:                                       ; preds = %entry
  %1 = load ptr, ptr %fsize, align 8
  br label %common.ret
}
