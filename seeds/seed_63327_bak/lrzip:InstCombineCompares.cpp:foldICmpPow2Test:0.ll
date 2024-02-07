target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_ZN7libzpaq10StateTableC2Ev(i32 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %cmp3 = icmp slt i32 %0, 0
  br i1 %cmp3, label %for.body4, label %for.cond

for.body4:                                        ; preds = %for.cond
  ret void
}
