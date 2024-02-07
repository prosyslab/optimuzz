target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteRiffHeader(i32 %call5, ptr %wpc.addr) {
entry:
  %format = alloca i32, align 4
  %tobool = icmp ne i32 %call5, 0
  %cond = select i1 %tobool, i32 3, i32 0
  store i32 %cond, ptr %format, align 4
  %0 = load i32, ptr %format, align 4
  %cmp = icmp eq i32 %0, 3
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %1 = load ptr, ptr %wpc.addr, align 8
  br label %common.ret
}
