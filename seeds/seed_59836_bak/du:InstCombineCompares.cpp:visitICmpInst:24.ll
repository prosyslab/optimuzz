target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %tenths) {
entry:
  %n.addr = alloca i64, align 8
  %amt = alloca i64, align 8
  %multiplier = alloca i64, align 8
  %0 = load i64, ptr %n.addr, align 8
  %1 = load i64, ptr %multiplier, align 8
  %mul = mul i64 %0, %1
  store i64 %mul, ptr %amt, align 8
  %2 = load i64, ptr %amt, align 8
  %3 = load i64, ptr %multiplier, align 8
  %div19 = udiv i64 %2, %3
  %4 = load i64, ptr %n.addr, align 8
  %cmp20 = icmp eq i64 %div19, %4
  br i1 %cmp20, label %if.then21, label %common.ret

common.ret:                                       ; preds = %if.then21, %entry
  ret ptr null

if.then21:                                        ; preds = %entry
  store i32 0, ptr %tenths, align 4
  br label %common.ret
}
