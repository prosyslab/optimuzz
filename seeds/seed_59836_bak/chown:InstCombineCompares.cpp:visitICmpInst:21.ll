target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @hash_initialize(ptr %table, i64 %0) {
entry:
  %tobool16 = icmp ne i64 %0, 0
  br i1 %tobool16, label %if.end18, label %common.ret

common.ret:                                       ; preds = %if.end18, %entry
  ret ptr null

if.end18:                                         ; preds = %entry
  %1 = load ptr, ptr %table, align 8
  br label %common.ret
}
