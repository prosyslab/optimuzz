target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printf_parse(ptr %cp, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret i32 0

while.body:                                       ; preds = %entry
  %1 = load ptr, ptr %cp, align 8
  br label %common.ret
}
