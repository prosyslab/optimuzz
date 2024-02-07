target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @offtostr(i64 %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %div = sdiv i64 %0, 10
  %cmp1 = icmp ne i64 %div, 0
  br i1 %cmp1, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret ptr null
}
