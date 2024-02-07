target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @RtfFontNumber(i32 %call2) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp3 = icmp eq i32 %call2, 0
  br i1 %cmp3, label %if.then, label %while.cond

if.then:                                          ; preds = %while.cond
  ret i32 0
}
