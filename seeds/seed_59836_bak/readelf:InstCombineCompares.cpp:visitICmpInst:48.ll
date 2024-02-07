target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @adjust_relative_path(ptr %name_len.addr, i64 %0) {
entry:
  %add = add i64 %0, 1
  store i64 %add, ptr %name_len.addr, align 8
  %cmp18 = icmp eq i64 %add, 0
  br i1 %cmp18, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret ptr null

if.end:                                           ; preds = %entry
  %1 = load i64, ptr %name_len.addr, align 8
  br label %common.ret
}
