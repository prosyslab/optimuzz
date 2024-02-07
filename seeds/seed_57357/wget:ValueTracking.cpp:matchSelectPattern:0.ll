target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @snprintf(ptr, i64, ptr, ...)

define ptr @retr_rate(double %0) {
entry:
  %cmp1 = fcmp oge double %0, 0.000000e+00
  %cond = select i1 %cmp1, i32 1, i32 0
  %call9 = call i32 (ptr, i64, ptr, ...) @snprintf(ptr null, i64 0, ptr null, i32 %cond, double 0.000000e+00, ptr null)
  ret ptr null
}
