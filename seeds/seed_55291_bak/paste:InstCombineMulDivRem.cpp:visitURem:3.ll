target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @set_char_quoting(ptr %uc, i8 %0, ptr %shift, i32 %1, i32 %shr, i32 %and, ptr %r, i32 %2) {
entry:
  %uc1 = alloca i8, align 1
  %shift2 = alloca i32, align 4
  %r3 = alloca i32, align 4
  br label %cond.true

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.true
  %3 = load i8, ptr %uc, align 1
  %conv1 = zext i8 %0 to i64
  %rem = urem i64 %conv1, 32
  %conv2 = trunc i64 %rem to i32
  store i32 %conv2, ptr %uc, align 4
  %4 = load i32, ptr undef, align 4
  %5 = load i32, ptr %uc, align 4
  %shr4 = lshr i32 1, %1
  %and5 = and i32 %1, 1
  store i32 %1, ptr %uc, align 4
  %6 = load i32, ptr %uc, align 4
  ret i32 %1
}
