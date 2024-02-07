target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @filespec_ext(i64 %call10, ptr %cp) {
entry:
  %cmp11 = icmp ule i64 %call10, 0
  br i1 %cmp11, label %if.then13, label %common.ret

common.ret:                                       ; preds = %if.then13, %entry
  ret ptr null

if.then13:                                        ; preds = %entry
  %0 = load ptr, ptr %cp, align 8
  br label %common.ret
}
