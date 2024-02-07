target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @trim_trailing_slash_or_dot(ptr %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %incdec.ptr10 = getelementptr i8, ptr %0, i64 -1
  %cmp11 = icmp eq ptr %incdec.ptr10, null
  br i1 %cmp11, label %if.then13, label %while.cond

if.then13:                                        ; preds = %while.cond
  ret void
}
