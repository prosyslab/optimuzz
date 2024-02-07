target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @filespec_ext(ptr %cp.0, i64 %call8) {
entry:
  %0 = icmp ult i64 %call8, 1
  %spec.select = select i1 %0, ptr %cp.0, ptr null
  ret ptr %spec.select
}
