target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @psStart(ptr %xscale, double %0, double %1) {
entry:
  %cmp26 = fcmp olt double %0, %1
  %cond30 = select i1 %cmp26, double 1.000000e+00, double 0.000000e+00
  store double %cond30, ptr %xscale, align 8
  ret i32 0
}
