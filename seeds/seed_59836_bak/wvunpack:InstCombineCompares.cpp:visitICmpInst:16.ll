target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteCaffHeader(ptr %chan_id, i8 %0) {
entry:
  %conv177 = zext i8 %0 to i32
  %cmp178 = icmp sge i32 %conv177, 1
  br i1 %cmp178, label %land.lhs.true180, label %common.ret

common.ret:                                       ; preds = %land.lhs.true180, %entry
  ret i32 0

land.lhs.true180:                                 ; preds = %entry
  %1 = load i8, ptr %chan_id, align 1
  br label %common.ret
}
