target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @tzalloc(ptr %name_size, i64 %0) {
entry:
  %cmp = icmp ult i64 %0, 1
  %cond5 = select i1 %cmp, i64 1, i64 0
  store i64 %cond5, ptr %name_size, align 8
  ret ptr null
}
