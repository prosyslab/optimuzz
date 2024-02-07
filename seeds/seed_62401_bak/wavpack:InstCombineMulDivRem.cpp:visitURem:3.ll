target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ParseRiffHeaderConfig(ptr %WaveHeader, i16 %0) {
entry:
  %conv238 = zext i16 %0 to i32
  %rem = srem i32 1, %conv238
  %tobool239 = icmp ne i32 %rem, 0
  br i1 %tobool239, label %if.then240, label %if.end241

if.then240:                                       ; preds = %entry
  store i32 0, ptr %WaveHeader, align 4
  br label %if.end241

if.end241:                                        ; preds = %if.then240, %entry
  ret i32 0
}
