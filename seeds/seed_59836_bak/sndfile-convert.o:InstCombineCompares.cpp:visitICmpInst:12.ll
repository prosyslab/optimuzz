target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call31, ptr %outfileminor) {
entry:
  %tobool = icmp ne i32 %call31, 0
  br i1 %tobool, label %common.ret, label %if.then32

common.ret:                                       ; preds = %if.then32, %entry
  ret i32 0

if.then32:                                        ; preds = %entry
  store i32 0, ptr %outfileminor, align 4
  br label %common.ret
}
