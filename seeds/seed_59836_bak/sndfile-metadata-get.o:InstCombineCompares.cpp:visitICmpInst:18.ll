target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.then37:                                        ; No predecessors!
  call void @process_args(ptr null, ptr null)
  ret i32 0
}

declare i32 @printf(ptr, ...)

define internal void @process_args(ptr %str, ptr %0) {
entry:
  %tobool182.not = icmp eq ptr %0, null
  %cond = select i1 %tobool182.not, ptr null, ptr %str
  %call183 = call i32 (ptr, ...) @printf(ptr null, ptr null, ptr %cond)
  ret void
}
