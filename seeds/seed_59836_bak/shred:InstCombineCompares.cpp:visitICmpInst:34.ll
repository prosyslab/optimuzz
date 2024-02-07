target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end39:                                         ; No predecessors!
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.end39
  %call50 = call i1 @wipefd()
  br label %for.cond
}

define internal i1 @wipefd() {
entry:
  br label %return

if.end5:                                          ; No predecessors!
  %call61 = call i1 @do_wipefd(ptr null, i1 false)
  br label %return

return:                                           ; preds = %if.end5, %entry
  ret i1 false
}

define internal i1 @do_wipefd(ptr %size, i1 %cmp60) {
entry:
  %0 = load i64, ptr %size, align 8
  %cond66 = select i1 %cmp60, i64 0, i64 512
  %cmp67 = icmp slt i64 %0, %cond66
  br i1 %cmp67, label %if.then69, label %if.end70

if.then69:                                        ; preds = %entry
  %1 = load i64, ptr %size, align 8
  br label %if.end70

if.end70:                                         ; preds = %if.then69, %entry
  ret i1 false
}
