target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteAiffHeader() {
entry:
  br label %return

if.then27:                                        ; No predecessors!
  call void @put_extended(i64 0)
  br label %return

return:                                           ; preds = %if.then27, %entry
  ret i32 0
}

define internal void @put_extended(i64 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %and = and i64 %0, -9223372036854775808
  %tobool = icmp ne i64 %and, 0
  br i1 %tobool, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret void
}
