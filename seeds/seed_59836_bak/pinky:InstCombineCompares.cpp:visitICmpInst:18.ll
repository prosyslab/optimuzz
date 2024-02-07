target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @canon_host_r(ptr %retval1, i1 %tobool6) {
entry:
  %tobool5 = icmp eq ptr %retval1, null
  %or.cond = select i1 %tobool5, i1 %tobool6, i1 false
  br i1 %or.cond, label %if.then7, label %if.end

if.then7:                                         ; preds = %entry
  %0 = load ptr, ptr %retval1, align 8
  br label %if.end

if.end:                                           ; preds = %if.then7, %entry
  ret ptr null
}
