target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @usage(i32 %0) {
entry:
  %cmp.not = icmp eq i32 %0, 0
  br i1 %cmp.not, label %if.else, label %do.body

do.body:                                          ; preds = %entry
  %call1 = call i32 (...) @fprintf()
  br label %if.else

if.else:                                          ; preds = %do.body, %entry
  ret void
}

declare i32 @fprintf(...)
