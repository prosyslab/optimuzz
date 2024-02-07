target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @x2nrealloc(ptr %s.addr, i64 %0) {
entry:
  %div = mul i64 128, %0
  %tobool3 = icmp ne i64 %div, 0
  %lnot.ext = zext i1 %tobool3 to i32
  %conv = sext i32 %lnot.ext to i64
  store i64 %conv, ptr %s.addr, align 8
  ret ptr null
}
