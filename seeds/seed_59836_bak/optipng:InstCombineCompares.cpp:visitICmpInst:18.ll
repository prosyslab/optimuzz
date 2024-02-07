target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @crc32_z() {
entry:
  br label %return

if.then1:                                         ; No predecessors!
  %call1 = call i64 @crc32_little(i64 0, i1 false)
  br label %return

return:                                           ; preds = %if.then1, %entry
  ret i64 0
}

define internal i64 @crc32_little(i64 %0, i1 %tobool) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %tobool1 = icmp ne i64 %0, 0
  %1 = select i1 %tobool, i1 %tobool1, i1 false
  br i1 %1, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i64 0
}
