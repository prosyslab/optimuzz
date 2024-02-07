target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @PSDataPalette() {
entry:
  %call31 = call ptr @limitMalloc(ptr null, i64 0)
  ret void
}

define internal ptr @limitMalloc(ptr %s.addr, i64 %0) {
entry:
  %cmp = icmp sgt i64 %0, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i64, ptr %s.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr null
}
