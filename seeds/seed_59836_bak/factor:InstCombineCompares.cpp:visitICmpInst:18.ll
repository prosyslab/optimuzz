target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @ireallocarray(ptr %n.addr, i64 %0) {
entry:
  %cmp = icmp eq i64 %0, 0
  %spec.store.select = select i1 %cmp, i64 0, i64 1
  store i64 %spec.store.select, ptr %n.addr, align 8
  ret ptr null
}
