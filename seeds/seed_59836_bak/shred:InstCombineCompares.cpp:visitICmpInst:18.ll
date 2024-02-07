target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @usage() {
entry:
  unreachable

if.else:                                          ; No predecessors!
  call void @emit_ancillary_info(ptr null, ptr null)
  unreachable
}

declare i32 @printf(ptr, ...)

define internal void @emit_ancillary_info(ptr %program.addr, ptr %0) {
entry:
  %cmp21 = icmp eq ptr %0, null
  %cond22 = select i1 %cmp21, ptr null, ptr %program.addr
  %call23 = call i32 (ptr, ...) @printf(ptr null, ptr null, ptr %cond22)
  ret void
}
