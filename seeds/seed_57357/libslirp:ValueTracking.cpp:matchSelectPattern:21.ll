target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @icmp_forward_error(ptr %s_ip_len) {
entry:
  %0 = load i32, ptr %s_ip_len, align 4
  %cmp89 = icmp ugt i32 %0, 548
  %spec.store.select = select i1 %cmp89, i32 548, i32 %0
  store i32 %spec.store.select, ptr %s_ip_len, align 4
  ret void
}
