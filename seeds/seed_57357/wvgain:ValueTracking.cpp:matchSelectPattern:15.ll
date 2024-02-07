target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(float %.pre) {
entry:
  br label %while.body87.i

while.body87.i:                                   ; preds = %while.body87.i, %entry
  %track_peak.1 = phi float [ %track_peak.2, %while.body87.i ], [ 0.000000e+00, %entry ]
  %cmp21.i.i = fcmp olt float %track_peak.1, %.pre
  %track_peak.2 = select i1 %cmp21.i.i, float 1.000000e+00, float 0.000000e+00
  br label %while.body87.i
}
