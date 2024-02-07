target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse(i32 %add449) {
entry:
  br label %yysetstate

yysetstate:                                       ; preds = %yysetstate, %entry
  %add4492 = add nsw i32 %add449, 1
  %cmp450 = icmp sle i32 0, %add4492
  br i1 %cmp450, label %yysetstate, label %if.end469

if.end469:                                        ; preds = %yysetstate
  ret i32 0
}
