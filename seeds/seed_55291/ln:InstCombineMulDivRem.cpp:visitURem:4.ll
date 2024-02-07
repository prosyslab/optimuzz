target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @set_char_quoting(ptr %uc, i8 %0, i64 %conv1) {
entry:
  %uc1 = alloca i8, align 1
  br label %cond.true

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.true
  %1 = load i8, ptr %uc, align 1
  %conv12 = zext i8 %0 to i64
  %rem = urem i64 %conv1, 32
  %conv2 = trunc i64 %rem to i32
  store i32 %conv2, ptr undef, align 4
  ret i32 0
}
