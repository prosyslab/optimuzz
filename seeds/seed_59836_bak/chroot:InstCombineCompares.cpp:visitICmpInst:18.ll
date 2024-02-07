target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @locale_charset(ptr %codeset, ptr %0) {
entry:
  %cmp = icmp eq ptr %0, null
  %spec.store.select = select i1 %cmp, ptr %codeset, ptr null
  store ptr %spec.store.select, ptr %codeset, align 8
  ret ptr null
}
