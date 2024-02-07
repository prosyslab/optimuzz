target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @gettext()

define ptr @adjust_relative_path(ptr %0) {
entry:
  %cmp22 = icmp eq ptr %0, null
  br i1 %cmp22, label %if.then24, label %common.ret

common.ret:                                       ; preds = %if.then24, %entry
  ret ptr null

if.then24:                                        ; preds = %entry
  %call25 = call ptr @gettext()
  br label %common.ret
}
