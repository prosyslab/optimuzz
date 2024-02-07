target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %pointlen, i64 %0, i1 %cmp4) {
entry:
  %cmp = icmp ult i64 0, %0
  %or.cond = select i1 %cmp, i1 %cmp4, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %pointlen, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr null
}
