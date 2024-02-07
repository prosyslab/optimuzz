target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteCaffHeader(ptr %call7, i1 %0, i1 %1) {
entry:
  %or.cond399 = select i1 %0, i1 %1, i1 false
  br i1 %or.cond399, label %if.then200, label %if.else202

if.then200:                                       ; preds = %entry
  store i32 0, ptr %call7, align 4
  br label %if.else202

if.else202:                                       ; preds = %if.then200, %entry
  ret i32 0
}
