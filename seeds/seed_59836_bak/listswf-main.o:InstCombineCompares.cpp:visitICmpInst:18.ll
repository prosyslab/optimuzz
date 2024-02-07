target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cws2fws(ptr %tmp_fd, i32 %0, i1 %tobool) {
entry:
  %cmp = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp, i1 %tobool, i1 false
  br i1 %or.cond, label %if.then2, label %if.end3

if.then2:                                         ; preds = %entry
  %1 = load ptr, ptr %tmp_fd, align 8
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %entry
  ret i32 0
}
