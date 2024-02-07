target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @diff_output_data(i64 %0, ...) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %cmp2 = icmp uge i64 %0, 1
  br i1 %cmp2, label %if.then4, label %for.cond

if.then4:                                         ; preds = %for.cond
  ret void
}
