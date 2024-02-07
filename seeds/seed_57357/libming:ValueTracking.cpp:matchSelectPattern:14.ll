target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @SWFShape_drawScaledCubicTo(ptr %t2, double %0, i1 %cmp90) {
entry:
  %cmp87 = fcmp ogt double %0, 0.000000e+00
  %or.cond = select i1 %cmp87, i1 %cmp90, i1 false
  br i1 %or.cond, label %if.then92, label %if.end95

if.then92:                                        ; preds = %entry
  %1 = load double, ptr %t2, align 8
  br label %if.end95

if.end95:                                         ; preds = %if.then92, %entry
  ret i32 0
}
