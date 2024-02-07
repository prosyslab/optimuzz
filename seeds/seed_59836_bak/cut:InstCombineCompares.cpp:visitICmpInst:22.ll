target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @getndelim2(ptr %offset.addr, i64 %0) {
entry:
  %cmp70 = icmp ult i64 9223372036854775807, %0
  br i1 %cmp70, label %if.then71, label %common.ret

common.ret:                                       ; preds = %if.then71, %entry
  ret i64 0

if.then71:                                        ; preds = %entry
  %1 = load i64, ptr %offset.addr, align 8
  br label %common.ret
}
