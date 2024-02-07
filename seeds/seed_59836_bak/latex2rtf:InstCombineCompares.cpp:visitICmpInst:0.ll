target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @open_cfg(ptr %fp) {
entry:
  %cmp = icmp ne ptr null, %fp
  br i1 %cmp, label %if.then2, label %common.ret

common.ret:                                       ; preds = %if.then2, %entry
  ret ptr null

if.then2:                                         ; preds = %entry
  %0 = load ptr, ptr %fp, align 8
  br label %common.ret
}
