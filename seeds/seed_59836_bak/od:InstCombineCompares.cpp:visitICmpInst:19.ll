target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printf_parse(ptr %max_precision_length) {
entry:
  %0 = load i64, ptr %max_precision_length, align 8
  %cmp333 = icmp ult i64 %0, 2
  %spec.store.select = select i1 %cmp333, i64 1, i64 %0
  store i64 %spec.store.select, ptr %max_precision_length, align 8
  ret i32 0
}
