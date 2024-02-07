target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_btowc(ptr %wc) {
entry:
  %0 = load i64, ptr %wc, align 8
  %cmp1 = icmp eq i64 %0, -1
  %1 = load i64, ptr %wc, align 8
  %cmp3 = icmp eq i64 %1, -2
  %or.cond = select i1 %cmp1, i1 true, i1 %cmp3
  br i1 %or.cond, label %common.ret, label %if.then5

common.ret:                                       ; preds = %if.then5, %entry
  ret i32 0

if.then5:                                         ; preds = %entry
  %2 = load i32, ptr %wc, align 4
  br label %common.ret
}
