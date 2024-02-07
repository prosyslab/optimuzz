target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i64 %call88, ptr %mp) {
entry:
  %cmp89 = icmp ult i64 %call88, 1
  br i1 %cmp89, label %if.then91, label %if.end93

if.then91:                                        ; preds = %entry
  %0 = load ptr, ptr %mp, align 8
  br label %if.end93

if.end93:                                         ; preds = %if.then91, %entry
  ret i32 0
}
