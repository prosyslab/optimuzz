target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @caps_check_list(ptr %0) {
entry:
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %while.cond, label %if.then4

if.then4:                                         ; preds = %entry
  ret void

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond
}
