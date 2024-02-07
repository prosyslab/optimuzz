target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha256_process_bytes(ptr %len.addr, i64 %0) {
entry:
  %cmp2 = icmp ugt i64 1, %0
  %cond = select i1 %cmp2, i64 1, i64 0
  store i64 %cond, ptr %len.addr, align 8
  ret void
}
