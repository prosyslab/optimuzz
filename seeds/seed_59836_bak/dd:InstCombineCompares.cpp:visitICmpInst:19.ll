target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %maxlen) {
entry:
  %0 = load i64, ptr %maxlen, align 8
  %cmp1168 = icmp ugt i64 %0, 2147483647
  %spec.store.select = select i1 %cmp1168, i64 2147483647, i64 %0
  store i64 %spec.store.select, ptr %maxlen, align 8
  ret ptr null
}
