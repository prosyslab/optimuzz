target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @set_cpu_affinity(ptr %__cpu, i64 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %cond.true, %for.cond, %entry
  %div = mul i64 %0, 8
  %cmp1 = icmp ult i64 %div, 1
  br i1 %cmp1, label %cond.true, label %for.cond

cond.true:                                        ; preds = %for.cond
  %1 = load i64, ptr %__cpu, align 8
  br label %for.cond
}
