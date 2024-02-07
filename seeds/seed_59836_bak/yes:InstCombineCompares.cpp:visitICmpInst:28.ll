target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %operandp, ptr %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %add.ptr9 = getelementptr ptr, ptr %0, i64 1
  %cmp10 = icmp ult ptr %add.ptr9, %operandp
  br i1 %cmp10, label %land.lhs.true, label %do.body

land.lhs.true:                                    ; preds = %do.body
  ret i32 0
}
