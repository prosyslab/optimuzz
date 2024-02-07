target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  store i32 0, ptr @print_text_marker, align 4
  ret i32 0
}

define internal i32 @print_text_marker() align 4 {
entry:
  %length = alloca i64, align 8
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %0 = load i64, ptr %length, align 8
  %dec = add nsw i64 %0, 1
  %cmp12 = icmp sge i64 %dec, 0
  br i1 %cmp12, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i32 0
}
