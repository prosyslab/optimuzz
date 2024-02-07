target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @base_len(ptr %len, i64 %0) {
entry:
  %cmp = icmp ult i64 0, %0
  br i1 %cmp, label %land.rhs, label %for.body

land.rhs:                                         ; preds = %entry
  %1 = load ptr, ptr %len, align 8
  br label %for.body

for.body:                                         ; preds = %land.rhs, %entry
  ret i64 0
}
