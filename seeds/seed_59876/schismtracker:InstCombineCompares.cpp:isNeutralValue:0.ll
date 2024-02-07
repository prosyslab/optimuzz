target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @csf_process_tick() {
entry:
  %call1 = call i32 @increment_order(ptr null, i32 0)
  ret i32 0
}

define internal i32 @increment_order(ptr %csf.addr, i32 %0) {
entry:
  %inc = add i32 %0, 1
  store i32 %inc, ptr %csf.addr, align 4
  %tobool4 = icmp ne i32 %inc, 0
  br i1 %tobool4, label %if.then5, label %common.ret

common.ret:                                       ; preds = %if.then5, %entry
  ret i32 0

if.then5:                                         ; preds = %entry
  %1 = load ptr, ptr %csf.addr, align 8
  br label %common.ret
}
