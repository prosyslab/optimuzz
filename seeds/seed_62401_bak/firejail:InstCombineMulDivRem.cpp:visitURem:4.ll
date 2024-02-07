target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @set_cpu_affinity(ptr %__cpu, i64 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %rem = urem i64 %0, 64
  store i64 %rem, ptr %__cpu, align 8
  br label %for.cond
}
