target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @mbschr(ptr %iter, i8 %0) {
entry:
  %conv9 = sext i8 %0 to i32
  %cmp10 = icmp ne i32 %conv9, 0
  br i1 %cmp10, label %if.end, label %common.ret

common.ret:                                       ; preds = %if.end, %entry
  ret ptr null

if.end:                                           ; preds = %entry
  %1 = load ptr, ptr %iter, align 8
  br label %common.ret
}
