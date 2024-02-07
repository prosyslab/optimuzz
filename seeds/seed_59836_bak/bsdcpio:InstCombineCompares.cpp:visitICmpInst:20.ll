target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @__archive_get_date() {
entry:
  br label %return

if.end74:                                         ; No predecessors!
  %call951 = call i64 @Convert(ptr null, i64 0)
  br label %return

return:                                           ; preds = %if.end74, %entry
  ret i64 0
}

define internal i64 @Convert(ptr %Year.addr, i64 %0) {
entry:
  %rem = srem i64 %0, 4
  %cmp5 = icmp eq i64 %rem, 0
  br i1 %cmp5, label %land.rhs, label %common.ret

common.ret:                                       ; preds = %land.rhs, %entry
  ret i64 0

land.rhs:                                         ; preds = %entry
  %1 = load i64, ptr %Year.addr, align 8
  br label %common.ret
}
