target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @_ZN7libzpaq10StateTable10num_statesEii(ptr %n0.addr, i32 %0) {
entry:
  %cmp2 = icmp slt i32 %0, 0
  %or.cond = select i1 %cmp2, i1 false, i1 true
  br i1 %or.cond, label %if.then8, label %lor.lhs.false4

lor.lhs.false4:                                   ; preds = %entry
  %1 = load i32, ptr %n0.addr, align 4
  br label %if.then8

if.then8:                                         ; preds = %lor.lhs.false4, %entry
  ret i32 0
}
