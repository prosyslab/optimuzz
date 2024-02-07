target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i8 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %while.cond, %entry
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %for.cond
  %conv30 = sext i8 %0 to i32
  %cmp31 = icmp eq i32 %conv30, 0
  br i1 %cmp31, label %while.cond, label %for.cond
}
