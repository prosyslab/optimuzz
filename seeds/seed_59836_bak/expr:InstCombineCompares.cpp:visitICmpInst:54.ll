target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @mbschr(i8 %0, i32 %1) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %conv16 = zext i8 %0 to i32
  %conv17 = trunc i32 %1 to i8
  %conv18 = zext i8 %conv17 to i32
  %cmp19 = icmp eq i32 %conv16, %conv18
  br i1 %cmp19, label %if.then21, label %for.cond

if.then21:                                        ; preds = %for.cond
  ret ptr null
}
