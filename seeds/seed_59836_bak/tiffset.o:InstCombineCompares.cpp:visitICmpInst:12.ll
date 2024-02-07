target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call16, ptr %stderr) {
entry:
  %cmp17 = icmp ne i32 %call16, 0
  br i1 %cmp17, label %if.then18, label %common.ret

common.ret:                                       ; preds = %if.then18, %entry
  ret i32 0

if.then18:                                        ; preds = %entry
  %0 = load ptr, ptr %stderr, align 8
  br label %common.ret
}
