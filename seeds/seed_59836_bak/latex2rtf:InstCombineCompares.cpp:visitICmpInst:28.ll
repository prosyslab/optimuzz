target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @CfgNext(ptr %last.addr, ptr %0) {
entry:
  %add.ptr6 = getelementptr ptr, ptr %0, i64 -1
  %cmp7 = icmp ult ptr %add.ptr6, %last.addr
  %spec.store.select = select i1 %cmp7, ptr null, ptr %last.addr
  store ptr %spec.store.select, ptr %last.addr, align 8
  ret ptr null
}
