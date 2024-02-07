target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sfe_apply_metadata_changes() {
entry:
  unreachable

if.end18:                                         ; No predecessors!
  %call201 = call i32 @merge_broadcast_info(i16 0)
  unreachable
}

define internal i32 @merge_broadcast_info(i16 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %conv174 = zext i16 %0 to i32
  %tobool176 = icmp ne i32 %conv174, 0
  br i1 %tobool176, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i32 0
}
