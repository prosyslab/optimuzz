target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @dos_to_unix_time(ptr %yr, i32 %0) {
entry:
  %rem = srem i32 %0, 4
  %cmp25 = icmp eq i32 %rem, 0
  br i1 %cmp25, label %land.lhs.true27, label %common.ret

common.ret:                                       ; preds = %land.lhs.true27, %entry
  ret i64 0

land.lhs.true27:                                  ; preds = %entry
  %1 = load i32, ptr %yr, align 4
  br label %common.ret
}
