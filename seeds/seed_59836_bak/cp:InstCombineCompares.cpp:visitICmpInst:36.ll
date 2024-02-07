target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @set_process_security_ctx(ptr %x.addr) {
entry:
  %tobool41 = icmp ne ptr %x.addr, null
  br i1 %tobool41, label %if.then42, label %common.ret

common.ret:                                       ; preds = %if.then42, %entry
  ret i1 false

if.then42:                                        ; preds = %entry
  %0 = load i8, ptr %x.addr, align 1
  br label %common.ret
}
