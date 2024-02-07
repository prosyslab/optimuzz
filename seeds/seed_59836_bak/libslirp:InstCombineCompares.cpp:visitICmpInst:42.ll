target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @if_output(ptr %so.addr, i8 %0) {
entry:
  %conv = zext i8 %0 to i32
  %tobool44 = icmp ne i32 %conv, 0
  br i1 %tobool44, label %if.then45, label %common.ret

common.ret:                                       ; preds = %if.then45, %entry
  ret void

if.then45:                                        ; preds = %entry
  %1 = load ptr, ptr %so.addr, align 8
  br label %common.ret
}
