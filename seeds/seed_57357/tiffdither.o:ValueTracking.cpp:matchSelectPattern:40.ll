target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  %cmp25 = icmp slt i32 %0, 0
  br i1 %cmp25, label %if.then26, label %if.end27

if.then26:                                        ; preds = %entry
  call void @usage()
  br label %if.end27

if.end27:                                         ; preds = %if.then26, %entry
  ret i32 0
}

declare void @usage()
