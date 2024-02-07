target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @net_configure_sandbox_ip() {
entry:
  ret void

if.else6:                                         ; No predecessors!
  %call1 = call ptr @in_netrange.1971(ptr null, i32 0)
  unreachable
}

define internal ptr @in_netrange.1971(ptr %ip.addr, i32 %0) {
entry:
  %and = and i32 %0, 1
  %and1 = and i32 1, %0
  %cmp = icmp ne i32 %and, %and1
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  store ptr null, ptr %ip.addr, align 8
  br label %common.ret
}
