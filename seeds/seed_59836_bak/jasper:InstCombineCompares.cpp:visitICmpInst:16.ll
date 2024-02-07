target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @addopt(ptr %n, i64 %0) {
entry:
  %cmp4 = icmp ugt i64 %0, 0
  br i1 %cmp4, label %if.then6, label %if.end8

if.then6:                                         ; preds = %entry
  %1 = load ptr, ptr %n, align 8
  br label %if.end8

if.end8:                                          ; preds = %if.then6, %entry
  ret i32 0
}
