target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yylex(ptr %yy_def, i16 %0) {
entry:
  br label %while.cond21

while.cond21:                                     ; preds = %if.then35, %while.cond21, %entry
  %conv32 = sext i16 %0 to i32
  store i32 %conv32, ptr %yy_def, align 4
  %1 = load i32, ptr %yy_def, align 4
  %cmp33 = icmp sge i32 %1, 0
  br i1 %cmp33, label %if.then35, label %while.cond21

if.then35:                                        ; preds = %while.cond21
  %2 = load i8, ptr %yy_def, align 1
  br label %while.cond21
}
