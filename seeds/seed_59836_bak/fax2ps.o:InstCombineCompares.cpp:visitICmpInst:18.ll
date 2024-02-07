target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printTIF(i32 %call2, i1 %tobool, ptr %compression) {
entry:
  %cmp = icmp slt i32 %call2, 0
  %or.cond = select i1 %tobool, i1 false, i1 %cmp
  br i1 %or.cond, label %if.then, label %lor.lhs.false4

lor.lhs.false4:                                   ; preds = %entry
  %0 = load i16, ptr %compression, align 2
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false4, %entry
  ret void
}
