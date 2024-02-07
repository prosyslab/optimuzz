target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %prec, i32 %0) {
entry:
  %and129 = and i32 %0, -65536
  %tobool130 = icmp ne i32 %and129, 0
  br i1 %tobool130, label %if.then131, label %if.end135

if.then131:                                       ; preds = %entry
  %1 = load i16, ptr %prec, align 2
  br label %if.end135

if.end135:                                        ; preds = %if.then131, %entry
  ret i32 0
}
