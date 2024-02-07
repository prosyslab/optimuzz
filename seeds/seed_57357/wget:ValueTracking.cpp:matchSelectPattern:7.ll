target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @print_decimal(ptr %number.addr, double %0) {
entry:
  %cmp = fcmp oge double %0, 0.000000e+00
  %. = select i1 %cmp, double 0.000000e+00, double 1.000000e+00
  store double %., ptr %number.addr, align 8
  ret ptr null
}
