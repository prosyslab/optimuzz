target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %text_width, i32 %0) {
entry:
  %cmp13 = icmp sle i32 %0, 0
  br i1 %cmp13, label %if.then14, label %if.end15

if.then14:                                        ; preds = %entry
  %1 = load ptr, ptr %text_width, align 8
  br label %if.end15

if.end15:                                         ; preds = %if.then14, %entry
  ret i32 0
}
