target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @try_tempname_len(i1 %call22, i1 %cmp24) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %0 = select i1 %call22, i1 %cmp24, i1 false
  br i1 %0, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i32 0
}
