target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ftoastr(ptr %abs_x, float %0) {
entry:
  %cmp27 = fcmp olt float %0, 0.000000e+00
  %cond29 = select i1 %cmp27, i32 1, i32 0
  store i32 %cond29, ptr %abs_x, align 4
  ret i32 0
}
