target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_tr_stored_block(ptr %s.addr, i32 %0) {
entry:
  %cmp = icmp sgt i32 %0, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %s.addr, align 4
  br label %common.ret
}
