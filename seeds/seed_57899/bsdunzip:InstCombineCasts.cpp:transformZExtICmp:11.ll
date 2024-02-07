target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @Ppmd8_MakeEscFreq(ptr %r, i32 %0) {
entry:
  %cmp42 = icmp eq i32 %0, 0
  %conv43 = zext i1 %cmp42 to i32
  store i32 %conv43, ptr %r, align 4
  ret ptr null
}
