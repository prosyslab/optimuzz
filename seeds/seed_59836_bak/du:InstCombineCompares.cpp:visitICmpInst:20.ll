target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @fprintftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, i32 0)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %year, i32 %0) {
entry:
  %rem1234 = srem i32 %0, 4
  %cmp1235 = icmp eq i32 %rem1234, 0
  br i1 %cmp1235, label %land.rhs1237, label %common.ret

common.ret:                                       ; preds = %land.rhs1237, %entry
  ret i64 0

land.rhs1237:                                     ; preds = %entry
  %1 = load i32, ptr %year, align 4
  br label %common.ret
}
