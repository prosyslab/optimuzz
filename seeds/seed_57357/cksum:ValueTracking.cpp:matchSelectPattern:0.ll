target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(x86_fp80 %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %cmp61 = fcmp ult x86_fp80 %0, 0xK00000000000000000000
  %1 = select i1 %cmp61, i1 false, i1 true
  br i1 %1, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret ptr null
}
