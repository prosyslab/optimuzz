target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @xpalloc(ptr %n0, i1 %0) {
entry:
  %spec.store.select = select i1 %0, i64 9223372036854775807, i64 0
  store i64 %spec.store.select, ptr %n0, align 8
  ret ptr null
}
