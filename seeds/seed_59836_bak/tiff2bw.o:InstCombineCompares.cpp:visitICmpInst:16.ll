target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %h, i32 %0) {
entry:
  %cmp170 = icmp ult i32 0, %0
  br i1 %cmp170, label %for.body172, label %common.ret

common.ret:                                       ; preds = %for.body172, %entry
  ret i32 0

for.body172:                                      ; preds = %entry
  %1 = load ptr, ptr %h, align 8
  br label %common.ret
}
