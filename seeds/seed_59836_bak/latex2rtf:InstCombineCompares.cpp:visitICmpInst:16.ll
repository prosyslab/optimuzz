target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @WriteEightBitChar(ptr %cThis.addr, i8 %0) {
entry:
  %conv = zext i8 %0 to i32
  %cmp = icmp sle i32 %conv, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %1 = load i8, ptr %cThis.addr, align 1
  br label %common.ret
}
