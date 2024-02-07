target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @try_tempname_len(ptr %attempts, i32 %0) {
entry:
  %cmp13 = icmp ult i32 0, %0
  br i1 %cmp13, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  store i64 0, ptr %attempts, align 8
  br label %common.ret
}
