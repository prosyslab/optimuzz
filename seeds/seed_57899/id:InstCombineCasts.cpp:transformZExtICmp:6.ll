target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %just_context, i8 %0) {
entry:
  %tobool48 = trunc i8 %0 to i1
  %lnot = xor i1 %tobool48, true
  %frombool50 = zext i1 %lnot to i8
  store i8 %frombool50, ptr %just_context, align 1
  ret i32 0
}
