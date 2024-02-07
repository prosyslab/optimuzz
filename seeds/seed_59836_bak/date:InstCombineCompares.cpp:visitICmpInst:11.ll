target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal(i32 %0) {
entry:
  br label %for.cond72

for.cond72:                                       ; preds = %for.cond72, %entry
  %cmp73 = icmp sle i32 %0, 0
  br i1 %cmp73, label %for.cond72, label %for.end

for.end:                                          ; preds = %for.cond72
  ret i64 0
}
