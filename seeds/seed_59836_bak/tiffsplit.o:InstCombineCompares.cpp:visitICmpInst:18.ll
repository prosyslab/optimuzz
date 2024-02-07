target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  %cmp7 = icmp slt i32 %0, 0
  %or.cond = select i1 %cmp7, i1 false, i1 true
  br i1 %or.cond, label %if.then11, label %if.end12

if.then11:                                        ; preds = %entry
  call void @usage()
  br label %if.end12

if.end12:                                         ; preds = %if.then11, %entry
  ret i32 0
}

declare void @usage()
