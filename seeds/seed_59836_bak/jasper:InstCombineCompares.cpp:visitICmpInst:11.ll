target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %cmdopts, i64 %0) {
entry:
  %cmp169 = icmp sge i64 %0, 0
  br i1 %cmp169, label %land.lhs.true171, label %common.ret

common.ret:                                       ; preds = %land.lhs.true171, %entry
  ret i32 0

land.lhs.true171:                                 ; preds = %entry
  %1 = load ptr, ptr %cmdopts, align 8
  br label %common.ret
}
