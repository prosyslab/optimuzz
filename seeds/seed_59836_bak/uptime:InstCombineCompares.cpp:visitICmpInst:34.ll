target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @fprintftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, i32 0, i1 false)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %pad, i32 %0, i1 %cmp14) {
entry:
  %cond = select i1 %cmp14, i32 0, i32 %0
  %conv18 = sext i32 %cond to i64
  %1 = load i64, ptr %pad, align 8
  %cmp19 = icmp ult i64 %1, %conv18
  br i1 %cmp19, label %cond.true21, label %common.ret

common.ret:                                       ; preds = %cond.true21, %entry
  ret i64 0

cond.true21:                                      ; preds = %entry
  %2 = load i64, ptr %pad, align 8
  br label %common.ret
}
