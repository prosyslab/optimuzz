target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %comment_arg, i1 %cmp126) {
entry:
  %cmp123 = icmp eq ptr %comment_arg, null
  %or.cond = select i1 %cmp123, i1 %cmp126, i1 false
  br i1 %or.cond, label %land.lhs.true128, label %common.ret

common.ret:                                       ; preds = %land.lhs.true128, %entry
  ret i32 0

land.lhs.true128:                                 ; preds = %entry
  %0 = load i32, ptr %comment_arg, align 4
  br label %common.ret
}
