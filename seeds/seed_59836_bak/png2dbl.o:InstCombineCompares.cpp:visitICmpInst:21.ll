target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @error(...)

define void @readPNG(i32 %0) {
entry:
  %cmp.not = icmp eq i32 %0, 0
  br i1 %cmp.not, label %if.end3, label %if.then2

if.then2:                                         ; preds = %entry
  call void (...) @error()
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %entry
  ret void
}
