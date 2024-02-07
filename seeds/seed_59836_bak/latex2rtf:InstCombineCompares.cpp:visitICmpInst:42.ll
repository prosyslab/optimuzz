target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @MonitorFontChanges() {
entry:
  %call1 = call i32 @strstart(ptr null, i8 0)
  ret void
}

define internal i32 @strstart(ptr %str.addr, i8 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %land.rhs, %while.cond, %entry
  %conv = sext i8 %0 to i32
  %tobool = icmp ne i32 %conv, 0
  br i1 %tobool, label %land.rhs, label %while.cond

land.rhs:                                         ; preds = %while.cond
  %1 = load ptr, ptr %str.addr, align 8
  br label %while.cond
}
