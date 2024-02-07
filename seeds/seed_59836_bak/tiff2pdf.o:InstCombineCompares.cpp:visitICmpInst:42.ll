target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_sample_realize_palette(ptr %component_count, i16 %0) {
entry:
  %conv = zext i16 %0 to i64
  %cmp = icmp ne i64 %conv, 0
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i64 0

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, ptr %component_count, align 4
  br label %common.ret
}
