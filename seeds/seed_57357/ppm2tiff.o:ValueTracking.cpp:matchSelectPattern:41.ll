target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %prec, i1 %cmp82, i1 %cmp84) {
entry:
  %or.cond1 = select i1 %cmp84, i1 false, i1 %cmp82
  br i1 %or.cond1, label %if.then89, label %if.end90

if.then89:                                        ; preds = %entry
  %0 = load ptr, ptr %prec, align 8
  br label %if.end90

if.end90:                                         ; preds = %if.then89, %entry
  ret i32 0
}
