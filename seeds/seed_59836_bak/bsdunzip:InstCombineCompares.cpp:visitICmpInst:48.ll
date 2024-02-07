target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @archive_string_ensure(ptr %as.addr, i64 %0, i64 %div) {
entry:
  %add13 = add i64 %0, %div
  %cmp15 = icmp ult i64 %add13, %0
  br i1 %cmp15, label %if.then16, label %common.ret

common.ret:                                       ; preds = %if.then16, %entry
  ret ptr null

if.then16:                                        ; preds = %entry
  %1 = load ptr, ptr %as.addr, align 8
  br label %common.ret
}
