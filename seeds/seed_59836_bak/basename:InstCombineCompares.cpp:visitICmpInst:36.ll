target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @setlocale_null_r() {
entry:
  %call1 = call i32 @setlocale_null_unlocked(ptr null)
  ret i32 0
}

define internal i32 @setlocale_null_unlocked(ptr %result) {
entry:
  %cmp = icmp eq ptr %result, null
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %0 = load i64, ptr %result, align 8
  br label %common.ret
}
