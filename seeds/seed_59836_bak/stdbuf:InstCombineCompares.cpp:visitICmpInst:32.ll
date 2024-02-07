target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printf_parse(ptr %a_allocated, i64 %0, i1 %cmp210) {
entry:
  %cond216 = select i1 %cmp210, i64 %0, i64 0
  %cmp217 = icmp ule i64 %cond216, 0
  br i1 %cmp217, label %if.then219, label %if.end221

if.then219:                                       ; preds = %entry
  %1 = load i64, ptr %a_allocated, align 8
  br label %if.end221

if.end221:                                        ; preds = %if.then219, %entry
  ret i32 0
}
