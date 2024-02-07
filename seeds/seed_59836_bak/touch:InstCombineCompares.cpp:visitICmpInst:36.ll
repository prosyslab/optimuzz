target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @usage() {
entry:
  unreachable

if.else:                                          ; No predecessors!
  call void @emit_ancillary_info(ptr null)
  unreachable
}

define internal void @emit_ancillary_info(ptr %map_prog) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %land.rhs, %while.cond, %entry
  %tobool = icmp ne ptr %map_prog, null
  br i1 %tobool, label %land.rhs, label %while.cond

land.rhs:                                         ; preds = %while.cond
  %0 = load ptr, ptr %map_prog, align 8
  br label %while.cond
}
