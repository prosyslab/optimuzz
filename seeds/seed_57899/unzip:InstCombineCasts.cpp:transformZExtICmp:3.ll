target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @flush(ptr %0, i32 %1) {
entry:
  %cmp54 = icmp ne i32 %1, 0
  %conv55 = zext i1 %cmp54 to i32
  store i32 %conv55, ptr %0, align 8
  ret i32 0
}
