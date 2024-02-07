target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @TIFFReadSeparateStripData(ptr %maxMalloc, i64 %0) {
entry:
  %cmp = icmp ne i64 %0, 0
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret void

land.lhs.true:                                    ; preds = %entry
  %1 = load i64, ptr %maxMalloc, align 8
  br label %common.ret
}
