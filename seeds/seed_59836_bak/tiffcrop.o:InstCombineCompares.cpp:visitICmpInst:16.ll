target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %dirnum, i32 %0) {
entry:
  %cmp50 = icmp ugt i32 1, %0
  br i1 %cmp50, label %if.then52, label %common.ret

common.ret:                                       ; preds = %if.then52, %entry
  ret i32 0

if.then52:                                        ; preds = %entry
  %1 = load ptr, ptr %dirnum, align 8
  br label %common.ret
}
