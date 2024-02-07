target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @__archive_read_filter_consume(ptr %skipped) {
entry:
  %0 = load i64, ptr %skipped, align 8
  %cmp7 = icmp slt i64 %0, 0
  %spec.store.select = select i1 %cmp7, i64 0, i64 %0
  store i64 %spec.store.select, ptr %skipped, align 8
  ret i64 0
}
