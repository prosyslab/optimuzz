target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(double %dec.lcssa.i, ptr %call251) {
entry:
  %conv5.i = fptrunc double %dec.lcssa.i to float
  %cmp11.i = fcmp olt float %conv5.i, -2.400000e+01
  %.conv5.i = select i1 %cmp11.i, float -2.400000e+01, float %conv5.i
  store float %.conv5.i, ptr %call251, align 4
  ret i32 0
}
