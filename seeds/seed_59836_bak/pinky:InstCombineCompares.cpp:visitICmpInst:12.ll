target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_fflush(i32 %call, ptr %stream.addr) {
entry:
  %cmp1 = icmp ne i32 %call, 0
  br i1 %cmp1, label %common.ret, label %if.then

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %stream.addr, align 8
  br label %common.ret
}
