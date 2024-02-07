target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @CmdFontShape(ptr %true_code, i32 %0) {
entry:
  %cmp = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %if.then, label %lor.lhs.false9

lor.lhs.false9:                                   ; preds = %entry
  %1 = load i32, ptr %true_code, align 4
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false9, %entry
  ret void
}
