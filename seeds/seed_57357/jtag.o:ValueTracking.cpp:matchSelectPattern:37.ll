target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %go, i32 %0, i1 %cmp67) {
entry:
  %cmp65 = icmp slt i32 %0, 0
  %or.cond = select i1 %cmp65, i1 %cmp67, i1 false
  br i1 %or.cond, label %if.then68, label %if.end73

if.then68:                                        ; preds = %entry
  %1 = load ptr, ptr %go, align 8
  br label %if.end73

if.end73:                                         ; preds = %if.then68, %entry
  ret i32 0
}
