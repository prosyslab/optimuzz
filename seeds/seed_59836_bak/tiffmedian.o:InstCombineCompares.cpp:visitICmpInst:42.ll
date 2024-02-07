target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %bitspersample, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp28 = icmp ne i32 %conv, 0
  br i1 %cmp28, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %1 = load i16, ptr %bitspersample, align 2
  br label %common.ret
}
