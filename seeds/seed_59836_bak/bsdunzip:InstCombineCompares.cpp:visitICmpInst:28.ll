target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @__archive_read_filter_ahead(ptr %filter.addr, ptr %0, i64 %1) {
entry:
  %add.ptr38 = getelementptr i8, ptr %0, i64 %1
  %cmp41 = icmp ugt ptr %add.ptr38, null
  br i1 %cmp41, label %if.then42, label %common.ret

common.ret:                                       ; preds = %if.then42, %entry
  ret ptr null

if.then42:                                        ; preds = %entry
  %2 = load ptr, ptr %filter.addr, align 8
  br label %common.ret
}
