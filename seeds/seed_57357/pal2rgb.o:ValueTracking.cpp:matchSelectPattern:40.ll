target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call25, ptr %shortv) {
entry:
  %tobool26 = icmp ne i32 %call25, 0
  br i1 %tobool26, label %lor.lhs.false, label %if.then29

lor.lhs.false:                                    ; preds = %entry
  %0 = load i16, ptr %shortv, align 2
  br label %if.then29

if.then29:                                        ; preds = %lor.lhs.false, %entry
  ret i32 0
}
