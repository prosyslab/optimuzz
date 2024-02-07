target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @filespec_path(ptr %filespec.addr, ptr %0, i64 %call) {
entry:
  %add.ptr = getelementptr inbounds i8, ptr %0, i64 %call
  %cmp = icmp eq ptr %add.ptr, null
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load ptr, ptr %filespec.addr, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  ret ptr null
}
