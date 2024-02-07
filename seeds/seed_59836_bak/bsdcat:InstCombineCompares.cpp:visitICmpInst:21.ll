target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @archive_string_ensure(ptr %as.addr, i64 %0) {
entry:
  %cmp3 = icmp eq i64 %0, 0
  br i1 %cmp3, label %if.then4, label %common.ret

common.ret:                                       ; preds = %if.then4, %entry
  ret ptr null

if.then4:                                         ; preds = %entry
  store i64 0, ptr %as.addr, align 8
  br label %common.ret
}
