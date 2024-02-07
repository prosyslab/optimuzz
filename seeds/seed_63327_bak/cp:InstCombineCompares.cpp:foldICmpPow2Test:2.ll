target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @set_process_security_ctx(ptr %x.addr, i8 %0) {
entry:
  %tobool = trunc i8 %0 to i1
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i1 false

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %x.addr, align 8
  br label %common.ret
}
