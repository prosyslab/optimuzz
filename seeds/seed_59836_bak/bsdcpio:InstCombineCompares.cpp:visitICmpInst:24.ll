target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @archive_random() {
entry:
  call void @la_arc4random_buf(i32 0)
  ret i32 0
}

define internal void @la_arc4random_buf(i32 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %if.then, %while.cond, %entry
  %dec1 = add nsw i32 %0, 1
  %cmp = icmp sle i32 %dec1, 0
  br i1 %cmp, label %if.then, label %while.cond

if.then:                                          ; preds = %while.cond
  call void @arc4_stir()
  br label %while.cond
}

declare void @arc4_stir()
