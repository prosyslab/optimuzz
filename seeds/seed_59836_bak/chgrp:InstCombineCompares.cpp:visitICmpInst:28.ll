target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.infomap = type { ptr, ptr }

define ptr @hash_get_next(ptr %bucket, ptr %0) {
entry:
  %incdec.ptr = getelementptr %struct.infomap, ptr %0, i32 1
  %cmp6 = icmp ult ptr %incdec.ptr, %bucket
  br i1 %cmp6, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret ptr null

while.body:                                       ; preds = %entry
  %1 = load ptr, ptr %bucket, align 8
  br label %common.ret
}
