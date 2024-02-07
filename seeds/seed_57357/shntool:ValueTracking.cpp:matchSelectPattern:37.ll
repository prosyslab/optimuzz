target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @launch_input() {
entry:
  call void @spawn(ptr null, i32 0, i1 false)
  ret ptr null
}

define internal void @spawn(ptr %nullfd, i32 %0, i1 %cmp26) {
entry:
  %cmp25 = icmp sgt i32 %0, 0
  %or.cond = select i1 %cmp25, i1 %cmp26, i1 false
  br i1 %or.cond, label %if.then27, label %if.end29

if.then27:                                        ; preds = %entry
  %1 = load i32, ptr %nullfd, align 4
  br label %if.end29

if.end29:                                         ; preds = %if.then27, %entry
  ret void
}
