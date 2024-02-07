target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @filespec_path(i8 %0) {
entry:
  %cond = icmp eq i8 %0, 0
  br i1 %cond, label %land.lhs.true, label %if.end13

land.lhs.true:                                    ; preds = %entry
  %cmp9 = icmp eq ptr null, null
  br label %if.end13

if.end13:                                         ; preds = %land.lhs.true, %entry
  ret ptr null
}
