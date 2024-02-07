target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %in) {
entry:
  %cmp21 = icmp eq ptr %in, null
  br i1 %cmp21, label %if.then22, label %common.ret

common.ret:                                       ; preds = %if.then22, %entry
  ret i32 0

if.then22:                                        ; preds = %entry
  %0 = load ptr, ptr %in, align 8
  br label %common.ret
}
