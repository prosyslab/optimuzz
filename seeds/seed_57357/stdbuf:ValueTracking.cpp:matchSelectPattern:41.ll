target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %has_precision, i1 %tobool813, i1 %cmp815) {
entry:
  %or.cond1 = select i1 %cmp815, i1 %tobool813, i1 false
  br i1 %or.cond1, label %if.end830, label %do.body821

do.body821:                                       ; preds = %entry
  %0 = load i64, ptr %has_precision, align 8
  br label %if.end830

if.end830:                                        ; preds = %do.body821, %entry
  ret ptr null
}
