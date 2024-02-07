target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @prog_update() {
entry:
  br label %return

if.end28:                                         ; No predecessors!
  switch i32 0, label %return [
    i32 1, label %return
    i32 2, label %return
    i32 3, label %sw.bb30
    i32 4, label %return
    i32 0, label %return
  ]

sw.bb30:                                          ; preds = %if.end28
  call void @prog_show_spin(i32 0)
  br label %return

return:                                           ; preds = %sw.bb30, %if.end28, %if.end28, %if.end28, %if.end28, %if.end28, %entry
  ret void
}

define internal void @prog_show_spin(i32 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %add = add nsw i32 %0, 1
  %cmp = icmp sle i32 %add, 0
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret void
}
