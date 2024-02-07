target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @TIFFReadSeparateStripData(ptr %samplesperpixel, i16 %0) {
entry:
  %conv11 = zext i16 %0 to i32
  %cmp12 = icmp slt i32 0, %conv11
  br i1 %cmp12, label %for.body14, label %common.ret

common.ret:                                       ; preds = %for.body14, %entry
  ret void

for.body14:                                       ; preds = %entry
  %1 = load i32, ptr %samplesperpixel, align 4
  br label %common.ret
}
