target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @fnfilter(ptr %call, i16 %0) {
entry:
  %conv8 = zext i16 %0 to i32
  %tobool9 = icmp ne i32 %conv8, 0
  br i1 %tobool9, label %common.ret, label %if.then10

common.ret:                                       ; preds = %if.then10, %entry
  ret ptr null

if.then10:                                        ; preds = %entry
  %1 = load ptr, ptr %call, align 8
  br label %common.ret
}
