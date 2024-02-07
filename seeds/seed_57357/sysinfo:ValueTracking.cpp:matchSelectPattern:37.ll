target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse(ptr %yychar, i32 %0, i1 %cmp66) {
entry:
  %cmp64 = icmp sle i32 0, %0
  %or.cond = select i1 %cmp64, i1 %cmp66, i1 false
  br i1 %or.cond, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i32, ptr %yychar, align 4
  br label %cond.false

cond.false:                                       ; preds = %cond.true, %entry
  ret i32 0
}
