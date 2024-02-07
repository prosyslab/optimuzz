target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printJpegStream(i32 %call1) {
entry:
  %cmp.not = icmp eq i32 %call1, 0
  br i1 %cmp.not, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %call2 = call i32 (...) @printf()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

declare i32 @printf(...)
