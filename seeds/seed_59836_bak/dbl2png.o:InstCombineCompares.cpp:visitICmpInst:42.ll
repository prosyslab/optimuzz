target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @readDBL(ptr %header, i8 %0) {
entry:
  %conv4 = zext i8 %0 to i32
  %cmp5 = icmp eq i32 %conv4, 0
  br i1 %cmp5, label %if.then7, label %common.ret

common.ret:                                       ; preds = %if.then7, %entry
  ret void

if.then7:                                         ; preds = %entry
  %1 = load i32, ptr %header, align 4
  br label %common.ret
}
