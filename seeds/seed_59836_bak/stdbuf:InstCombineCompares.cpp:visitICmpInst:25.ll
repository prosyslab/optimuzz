target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(i64 %shr) {
entry:
  br label %do.body821

do.body821:                                       ; preds = %do.body821, %entry
  %shr2 = lshr i64 %shr, 1
  %cmp827 = icmp ne i64 %shr2, 0
  br i1 %cmp827, label %do.body821, label %do.end829

do.end829:                                        ; preds = %do.body821
  ret ptr null
}
