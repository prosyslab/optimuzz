target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @memchr2(ptr %c1_in.addr, i32 %0, ptr %c1, i8 %1) {
entry:
  %conv = trunc i32 %0 to i8
  store i8 %conv, ptr %c1, align 1
  %2 = load i8, ptr %c1, align 1
  %conv2 = zext i8 %2 to i32
  %conv3 = zext i8 %1 to i32
  %cmp = icmp eq i32 %conv2, %conv3
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %3 = load ptr, ptr %c1_in.addr, align 8
  br label %common.ret
}
