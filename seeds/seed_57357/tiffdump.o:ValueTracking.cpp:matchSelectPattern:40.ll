target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @usage()

define i32 @main(i32 %0) {
entry:
  %cmp11 = icmp slt i32 %0, 0
  br i1 %cmp11, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @usage()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 0
}
