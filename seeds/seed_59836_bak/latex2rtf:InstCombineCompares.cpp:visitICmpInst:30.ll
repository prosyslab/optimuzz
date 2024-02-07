target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @CfgNext(ptr %last.addr, ptr %0) {
entry:
  %1 = load ptr, ptr %last.addr, align 8
  %add.ptr6 = getelementptr ptr, ptr %0, i64 -1
  %cmp7 = icmp ugt ptr %1, %add.ptr6
  br i1 %cmp7, label %if.then8, label %common.ret

common.ret:                                       ; preds = %if.then8, %entry
  ret ptr null

if.then8:                                         ; preds = %entry
  store ptr null, ptr %last.addr, align 8
  br label %common.ret
}
