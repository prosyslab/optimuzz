target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_set_unknown_chunks() {
entry:
  ret void

if.end8:                                          ; No predecessors!
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.end8
  %call161 = call i8 @check_location(ptr null)
  br label %for.cond
}

define internal i8 @check_location(ptr %location.addr) {
entry:
  %.pre = load i32, ptr %location.addr, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %sub = sub i32 0, %.pre
  %and10 = and i32 %.pre, %sub
  %cmp11 = icmp ne i32 %.pre, %and10
  br i1 %cmp11, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i8 0
}
