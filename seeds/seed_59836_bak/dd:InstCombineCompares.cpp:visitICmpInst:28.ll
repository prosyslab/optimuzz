target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %incdec.ptr = getelementptr i8, ptr %0, i64 1
  %cmp268.not = icmp eq ptr %incdec.ptr, null
  br i1 %cmp268.not, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  ret ptr null
}
