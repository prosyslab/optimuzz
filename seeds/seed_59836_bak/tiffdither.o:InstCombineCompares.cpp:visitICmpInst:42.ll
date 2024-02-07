target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %samplesperpixel, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp33 = icmp ne i32 %conv, 0
  br i1 %cmp33, label %if.then35, label %common.ret

common.ret:                                       ; preds = %if.then35, %entry
  ret i32 0

if.then35:                                        ; preds = %entry
  %1 = load ptr, ptr %samplesperpixel, align 8
  br label %common.ret
}
