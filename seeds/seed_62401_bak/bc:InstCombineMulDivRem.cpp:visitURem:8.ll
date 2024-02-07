target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @bc_divide(ptr %ptr1, i16 %conv276) {
entry:
  %add277 = add i16 %conv276, 1
  %rem = urem i16 %add277, 10
  %conv278 = trunc i16 %rem to i8
  store i8 %conv278, ptr %ptr1, align 1
  ret i32 0
}
