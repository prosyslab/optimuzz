target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i64 %call483, ptr %stderr) {
entry:
  %add484 = add nsw i64 %call483, 1
  %cmp491 = icmp sle i64 %add484, 0
  br i1 %cmp491, label %if.then493, label %common.ret

common.ret:                                       ; preds = %if.then493, %entry
  ret i32 0

if.then493:                                       ; preds = %entry
  %0 = load ptr, ptr %stderr, align 8
  br label %common.ret
}
