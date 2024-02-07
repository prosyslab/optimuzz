target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %outfileminor, i1 %cmp292, i1 %cmp295) {
entry:
  %or.cond = select i1 %cmp292, i1 false, i1 %cmp295
  br i1 %or.cond, label %if.then312, label %lor.lhs.false297

lor.lhs.false297:                                 ; preds = %entry
  %0 = load i32, ptr %outfileminor, align 4
  br label %if.then312

if.then312:                                       ; preds = %lor.lhs.false297, %entry
  ret i32 0
}
