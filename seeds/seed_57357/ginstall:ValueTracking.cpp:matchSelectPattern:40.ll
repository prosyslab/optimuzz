target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @set_process_security_ctx(ptr %x.addr, i8 %0) {
entry:
  %tobool1 = trunc i8 %0 to i1
  br i1 %tobool1, label %lor.rhs, label %lor.end

lor.rhs:                                          ; preds = %entry
  %1 = load ptr, ptr %x.addr, align 8
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  ret i1 false
}
