target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @ctf_errmsg(ptr %error.addr, i32 %0) {
entry:
  %sub = sub nsw i32 %0, 1000
  %cmp1 = icmp slt i32 %sub, 0
  br i1 %cmp1, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %error.addr, align 4
  br label %common.ret
}
