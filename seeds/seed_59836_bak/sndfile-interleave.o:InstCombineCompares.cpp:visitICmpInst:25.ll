target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  %sub9 = sub nsw i32 %0, 1
  %cmp10 = icmp sgt i32 %sub9, 0
  br i1 %cmp10, label %if.then11, label %common.ret

common.ret:                                       ; preds = %if.then11, %entry
  ret i32 0

if.then11:                                        ; preds = %entry
  %call12 = call i32 (...) @printf()
  br label %common.ret
}

declare i32 @printf(...)
