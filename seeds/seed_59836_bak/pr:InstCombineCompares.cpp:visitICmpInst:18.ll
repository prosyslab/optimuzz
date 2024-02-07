target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @rpl_mbrtoc32(ptr %ps.addr, ptr %0) {
entry:
  %cmp1 = icmp eq ptr %0, null
  %spec.store.select = select i1 %cmp1, ptr %ps.addr, ptr null
  store ptr %spec.store.select, ptr %ps.addr, align 8
  ret i64 0
}
