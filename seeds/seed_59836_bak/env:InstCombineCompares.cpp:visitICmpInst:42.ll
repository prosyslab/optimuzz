target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @sig2str(i32 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %conv = zext i32 %0 to i64
  %cmp = icmp ult i64 %conv, 1
  br i1 %cmp, label %for.cond, label %for.end

for.end:                                          ; preds = %for.cond
  ret i32 0
}
