target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @snprintf(ptr, i64, ptr, ...)

define ptr @human_readable(double %0, double %conv10) {
entry:
  %cmp11 = fcmp olt double %0, %conv10
  %cond = select i1 %cmp11, i32 1, i32 0
  %call14 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr null, i64 0, ptr null, i32 %cond, double 0.000000e+00, i32 0)
  ret ptr null
}
