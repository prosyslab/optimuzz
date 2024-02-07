target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @cpio_i64toa(ptr %n) {
entry:
  %0 = load i64, ptr %n, align 8
  %cmp = icmp slt i64 %0, 0
  %sub = sub nsw i64 0, %0
  %cond = select i1 %cmp, i64 %sub, i64 %0
  store i64 %cond, ptr %n, align 8
  ret ptr null
}
