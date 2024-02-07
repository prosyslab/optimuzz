target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @__archive_read_filter_ahead(ptr %filter.addr, i64 %0) {
entry:
  %cmp6 = icmp ugt i64 %0, 0
  br i1 %cmp6, label %if.then7, label %common.ret

common.ret:                                       ; preds = %if.then7, %entry
  ret ptr null

if.then7:                                         ; preds = %entry
  %1 = load ptr, ptr %filter.addr, align 8
  br label %common.ret
}
