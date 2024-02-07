target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  br label %while.body42

while.body42:                                     ; preds = %while.body42, %entry
  %memchr.bounds = icmp ugt i32 %0, 0
  %memchr1.not = select i1 %memchr.bounds, i1 false, i1 true
  br i1 %memchr1.not, label %if.end51, label %while.body42

if.end51:                                         ; preds = %while.body42
  ret i32 0
}
