target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %i, i32 %0) {
entry:
  %cmp = icmp sgt i32 %0, 0
  br i1 %cmp, label %if.then2, label %if.end

if.then2:                                         ; preds = %entry
  %1 = load i32, ptr %i, align 4
  br label %if.end

if.end:                                           ; preds = %if.then2, %entry
  ret i32 0
}
