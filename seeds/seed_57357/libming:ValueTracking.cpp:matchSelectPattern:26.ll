target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @SWFShape_drawArc(ptr %delta, i32 %conv) {
entry:
  %call = call i32 @abs(i32 %conv)
  %cmp = icmp sge i32 %call, 0
  %spec.store.select = select i1 %cmp, double 0.000000e+00, double 1.000000e+00
  store double %spec.store.select, ptr %delta, align 8
  ret void
}

declare i32 @abs(i32)
