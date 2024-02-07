target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yylex(i32 %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %cmp = icmp ne i32 0, %0
  br i1 %cmp, label %while.body29, label %do.body

while.body29:                                     ; preds = %do.body
  ret i32 0
}
