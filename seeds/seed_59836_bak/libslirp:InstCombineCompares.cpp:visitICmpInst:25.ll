target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cksum(i32 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %sub14 = sub nsw i32 %0, 32
  %cmp15 = icmp sge i32 %sub14, 0
  br i1 %cmp15, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i32 0
}
