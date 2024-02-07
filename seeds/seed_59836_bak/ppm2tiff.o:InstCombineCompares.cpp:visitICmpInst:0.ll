target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %prec, i32 %0) {
entry:
  %cmp84 = icmp eq i32 0, %0
  br i1 %cmp84, label %if.then89, label %lor.lhs.false86

lor.lhs.false86:                                  ; preds = %entry
  %1 = load i32, ptr %prec, align 4
  br label %if.then89

if.then89:                                        ; preds = %lor.lhs.false86, %entry
  ret i32 0
}
