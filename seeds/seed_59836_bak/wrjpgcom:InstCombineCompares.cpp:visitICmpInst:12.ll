target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %arg, i32 %conv8) {
entry:
  %cmp9 = icmp ne i32 %conv8, 0
  br i1 %cmp9, label %if.then11, label %common.ret

common.ret:                                       ; preds = %if.then11, %entry
  ret i32 0

if.then11:                                        ; preds = %entry
  %0 = load ptr, ptr %arg, align 8
  br label %common.ret
}
