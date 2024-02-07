target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @filespec_ext(ptr %cp, ptr %0) {
entry:
  %incdec.ptr = getelementptr i8, ptr %0, i32 -1
  %cmp = icmp uge ptr %incdec.ptr, %cp
  br i1 %cmp, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret ptr null

while.body:                                       ; preds = %entry
  %1 = load ptr, ptr %cp, align 8
  br label %common.ret
}
