target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printTIF(ptr %compression, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp = icmp slt i32 %conv, 1
  br i1 %cmp, label %if.then, label %lor.lhs.false4

lor.lhs.false4:                                   ; preds = %entry
  %1 = load i16, ptr %compression, align 2
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false4, %entry
  ret void
}
