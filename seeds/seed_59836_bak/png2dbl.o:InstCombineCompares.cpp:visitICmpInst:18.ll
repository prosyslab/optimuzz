target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @readPNG(ptr %agg.result, i32 %0, i1 %cmp139) {
entry:
  %cmp142 = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp139, i1 false, i1 %cmp142
  br i1 %or.cond, label %if.then144, label %common.ret

common.ret:                                       ; preds = %if.then144, %entry
  ret void

if.then144:                                       ; preds = %entry
  %1 = load i32, ptr %agg.result, align 4
  br label %common.ret
}
