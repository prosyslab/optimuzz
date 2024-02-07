target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @memcasecmp(ptr %U1, i32 %0) {
entry:
  %sub = sub i32 %0, 1
  %tobool = icmp ne i32 %sub, 0
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %U1, align 4
  br label %common.ret
}
