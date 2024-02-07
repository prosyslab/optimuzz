target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @PSDataBW(ptr %cp, ptr %0) {
entry:
  br label %for.cond21

for.cond21:                                       ; preds = %for.cond21, %entry
  %incdec.ptr = getelementptr i8, ptr %0, i64 -1
  %cmp22.not = icmp ult ptr %incdec.ptr, %cp
  br i1 %cmp22.not, label %for.end, label %for.cond21

for.end:                                          ; preds = %for.cond21
  ret void
}
