target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @char_unicode_to_cp437(ptr %c.addr, i32 %0, i1 %cmp1) {
entry:
  %cmp = icmp uge i32 %0, 1
  %or.cond = select i1 %cmp, i1 %cmp1, i1 false
  br i1 %or.cond, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %c.addr, align 4
  br label %common.ret
}
