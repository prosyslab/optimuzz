target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @mgetgroups(i32 %0) {
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %cmp16 = icmp sle i32 0, %0
  br i1 %cmp16, label %if.then18, label %while.body

if.then18:                                        ; preds = %while.body
  ret i32 0
}
