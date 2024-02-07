target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @error(...)

define void @readDBL(ptr %0) {
entry:
  %tobool.not = icmp eq ptr %0, null
  br i1 %tobool.not, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void (...) @error()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
