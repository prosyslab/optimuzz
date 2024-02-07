target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_write_pdf_xobject_icccs(ptr %buflen, i32 %0) {
entry:
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %common.ret, label %if.else

common.ret:                                       ; preds = %if.else, %entry
  ret i64 0

if.else:                                          ; preds = %entry
  %1 = load i32, ptr %buflen, align 4
  br label %common.ret
}
