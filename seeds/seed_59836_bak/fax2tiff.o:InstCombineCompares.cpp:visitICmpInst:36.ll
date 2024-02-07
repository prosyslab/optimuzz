target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @copyFaxFile(ptr %tifin.addr) {
entry:
  %cmp6 = icmp eq ptr %tifin.addr, null
  br i1 %cmp6, label %if.then7, label %common.ret

common.ret:                                       ; preds = %if.then7, %entry
  ret i32 0

if.then7:                                         ; preds = %entry
  %0 = load ptr, ptr %tifin.addr, align 8
  br label %common.ret
}
