target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call6) {
entry:
  %cmp7 = icmp eq i32 %call6, 0
  br i1 %cmp7, label %if.then8, label %if.end10

if.then8:                                         ; preds = %entry
  %call9 = call i32 (...) @printf()
  br label %if.end10

if.end10:                                         ; preds = %if.then8, %entry
  ret i32 0
}

declare i32 @printf(...)
