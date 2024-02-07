target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(float %conv5.i, ptr %call251) {
entry:
  %cmp7.i = fcmp ogt float %conv5.i, 0.000000e+00
  %retval.0.i640 = select i1 %cmp7.i, float 1.000000e+00, float 0.000000e+00
  store float %retval.0.i640, ptr %call251, align 4
  ret i32 0
}
