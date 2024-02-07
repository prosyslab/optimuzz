target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @ctf_bufopen_internal(ptr %symsect.addr, i1 %cmp1, i1 %cmp2) {
entry:
  %or.cond1 = select i1 %cmp2, i1 %cmp1, i1 false
  br i1 %or.cond1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %symsect.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr null
}
