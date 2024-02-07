target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_ZN7libzpaq10StateTableC2Ev(i32 %0, i32 %1) {
entry:
  br label %for.cond2

for.cond2:                                        ; preds = %for.cond2, %entry
  %cmp3 = icmp sle i32 %0, %1
  br i1 %cmp3, label %for.cond2, label %for.end

for.end:                                          ; preds = %for.cond2
  ret void
}
