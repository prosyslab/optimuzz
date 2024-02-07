target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @if_output(ptr %so.addr) {
entry:
  %tobool33 = icmp ne ptr %so.addr, null
  br i1 %tobool33, label %if.then34, label %common.ret

common.ret:                                       ; preds = %if.then34, %entry
  ret void

if.then34:                                        ; preds = %entry
  %0 = load ptr, ptr %so.addr, align 8
  br label %common.ret
}
