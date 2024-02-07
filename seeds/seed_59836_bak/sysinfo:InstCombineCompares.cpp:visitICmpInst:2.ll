target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @yy_flush_buffer(ptr %b.addr) {
entry:
  %tobool = icmp ne ptr %b.addr, null
  br i1 %tobool, label %if.end, label %common.ret

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %0 = load ptr, ptr %b.addr, align 8
  br label %common.ret
}
