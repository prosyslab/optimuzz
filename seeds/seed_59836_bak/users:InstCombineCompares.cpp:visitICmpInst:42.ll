target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fopen(ptr %p, i8 %0) {
entry:
  %conv2 = sext i8 %0 to i32
  %cond = icmp eq i32 %conv2, 0
  br i1 %cond, label %common.ret, label %sw.bb

common.ret:                                       ; preds = %sw.bb, %entry
  ret ptr null

sw.bb:                                            ; preds = %entry
  store i32 0, ptr %p, align 4
  br label %common.ret
}
