target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @adjust_relative_path(ptr %amt, i64 %0) {
entry:
  %cmp18 = icmp eq i64 %0, 0
  br i1 %cmp18, label %if.then20, label %if.end

if.then20:                                        ; preds = %entry
  store ptr null, ptr %amt, align 8
  br label %if.end

if.end:                                           ; preds = %if.then20, %entry
  ret ptr null
}
