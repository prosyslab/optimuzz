target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @cpio_i64toa(ptr %n0.addr, i64 %0) {
entry:
  %cmp = icmp slt i64 %0, 0
  %1 = load i64, ptr %n0.addr, align 8
  %sub = sub nsw i64 0, %1
  %cond = select i1 %cmp, i64 %sub, i64 %1
  store i64 %cond, ptr %n0.addr, align 8
  ret ptr null
}
