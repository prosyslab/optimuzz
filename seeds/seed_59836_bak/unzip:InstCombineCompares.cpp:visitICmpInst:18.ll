target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @fnfilter(ptr %slim, i1 %cmp5) {
entry:
  %cmp3 = icmp uge ptr null, %slim
  %or.cond = select i1 %cmp3, i1 %cmp5, i1 false
  br i1 %or.cond, label %if.then6, label %if.end7

if.then6:                                         ; preds = %entry
  %0 = load ptr, ptr %slim, align 8
  br label %if.end7

if.end7:                                          ; preds = %if.then6, %entry
  ret ptr null
}
