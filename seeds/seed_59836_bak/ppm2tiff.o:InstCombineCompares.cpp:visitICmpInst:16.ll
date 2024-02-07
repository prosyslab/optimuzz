target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %bpp, i16 %0) {
entry:
  %conv195 = zext i16 %0 to i32
  %cmp196 = icmp sle i32 %conv195, 0
  br i1 %cmp196, label %if.then198, label %common.ret

common.ret:                                       ; preds = %if.then198, %entry
  ret i32 0

if.then198:                                       ; preds = %entry
  %1 = load i16, ptr %bpp, align 2
  br label %common.ret
}
