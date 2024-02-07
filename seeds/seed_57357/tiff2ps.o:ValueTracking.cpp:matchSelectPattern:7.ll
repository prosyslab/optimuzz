target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @psStart(ptr %psheight.addr, double %0) {
entry:
  %cmp6 = fcmp ole double %0, 0.000000e+00
  %cond = select i1 %cmp6, double 1.000000e+00, double 0.000000e+00
  store double %cond, ptr %psheight.addr, align 8
  ret i32 0
}
