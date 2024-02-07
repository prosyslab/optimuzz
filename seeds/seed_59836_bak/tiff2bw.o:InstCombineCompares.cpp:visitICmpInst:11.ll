target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %i, i32 %0) {
entry:
  %cmp136 = icmp sge i32 %0, 0
  br i1 %cmp136, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %i, align 8
  br label %common.ret
}
