target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %size, i64 %0) {
entry:
  %cmp10 = icmp ult i64 0, %0
  br i1 %cmp10, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  %1 = load i64, ptr %size, align 8
  br label %common.ret
}
