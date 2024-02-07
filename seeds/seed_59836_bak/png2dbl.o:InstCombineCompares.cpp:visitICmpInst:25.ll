target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @error(...)

define void @readPNG(i64 %call) {
entry:
  %conv = trunc i64 %call to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %if.then2, label %if.end3

if.then2:                                         ; preds = %entry
  call void (...) @error()
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %entry
  ret void
}
