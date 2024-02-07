target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha4_update() {
entry:
  ret void

if.then9:                                         ; No predecessors!
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %if.then9
  call void @sha4_process(i32 0)
  br label %while.cond
}

define internal void @sha4_process(i32 %inc454) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %inc4542 = add nsw i32 %inc454, 1
  %cmp455 = icmp slt i32 %inc4542, 0
  br i1 %cmp455, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}
