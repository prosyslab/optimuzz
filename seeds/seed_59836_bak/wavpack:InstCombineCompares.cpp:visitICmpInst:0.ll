target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.WaveHeader = type { i16, i16, i32, i32, i16, i16, i16, i16, i32, i16, [14 x i8] }

define i32 @ParseRiffHeaderConfig(i32 %0, ptr %WaveHeader) {
entry:
  %cmp224 = icmp slt i32 0, %0
  br i1 %cmp224, label %if.then240, label %lor.lhs.false226

lor.lhs.false226:                                 ; preds = %entry
  %BlockAlign227 = getelementptr %struct.WaveHeader, ptr %WaveHeader, i32 0, i32 4
  br label %if.then240

if.then240:                                       ; preds = %lor.lhs.false226, %entry
  ret i32 0
}
