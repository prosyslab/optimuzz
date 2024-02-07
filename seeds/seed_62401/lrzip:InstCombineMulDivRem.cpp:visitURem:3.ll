target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @LzmaProps_Decode(ptr %d, i8 %0) {
entry:
  %conv22 = zext i8 %0 to i32
  %rem = srem i32 %conv22, 9
  store i32 %rem, ptr %d, align 4
  ret i32 0
}
