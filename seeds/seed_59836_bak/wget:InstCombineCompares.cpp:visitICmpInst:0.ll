target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @connect_to_ip(i32 %call1, ptr %str) {
entry:
  %cmp = icmp ne i32 0, %call1
  br i1 %cmp, label %if.then2, label %common.ret

common.ret:                                       ; preds = %if.then2, %entry
  ret i32 0

if.then2:                                         ; preds = %entry
  store ptr null, ptr %str, align 8
  br label %common.ret
}
