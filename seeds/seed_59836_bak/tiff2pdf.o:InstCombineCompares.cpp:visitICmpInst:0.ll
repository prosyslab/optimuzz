target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_write_pdf_string(ptr %len, i64 %0) {
entry:
  %cmp = icmp ult i64 0, %0
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i64 0

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %len, align 8
  br label %common.ret
}
