target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @SWFMovie_toOutput(i16 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %conv15 = zext i16 %0 to i32
  %cmp16 = icmp slt i32 0, %conv15
  br i1 %cmp16, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret ptr null
}
