target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printJpegStream(i32 %call, ptr %f.addr) {
entry:
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret void

while.body:                                       ; preds = %entry
  %0 = load ptr, ptr %f.addr, align 8
  br label %common.ret
}
