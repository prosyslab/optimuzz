target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @indent(ptr %gIndent, i32 %0) {
entry:
  %cmp1.not = icmp eq i32 %0, 0
  br i1 %cmp1.not, label %common.ret, label %if.then2

common.ret:                                       ; preds = %if.then2, %entry
  ret ptr null

if.then2:                                         ; preds = %entry
  store i32 0, ptr %gIndent, align 4
  br label %common.ret
}
