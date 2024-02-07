target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ParseAiffHeaderConfig(ptr %common_chunk, i8 %0) {
entry:
  %conv156 = zext i8 %0 to i32
  store i32 %conv156, ptr %common_chunk, align 4
  %1 = load i32, ptr %common_chunk, align 4
  %cmp157 = icmp sge i32 %1, 1
  br i1 %cmp157, label %land.lhs.true159, label %common.ret

common.ret:                                       ; preds = %land.lhs.true159, %entry
  ret i32 0

land.lhs.true159:                                 ; preds = %entry
  %2 = load i32, ptr %common_chunk, align 4
  br label %common.ret
}
