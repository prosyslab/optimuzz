target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_combine_row(ptr %bytes_to_copy, i32 %0) {
entry:
  %conv236 = zext i32 %0 to i64
  %rem = urem i64 %conv236, 2
  %cmp237 = icmp eq i64 %rem, 0
  br i1 %cmp237, label %land.lhs.true239, label %common.ret

common.ret:                                       ; preds = %land.lhs.true239, %entry
  ret void

land.lhs.true239:                                 ; preds = %entry
  %1 = load i32, ptr %bytes_to_copy, align 4
  br label %common.ret
}
