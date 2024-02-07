target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @read_buffer(ptr %cnt.addr) {
entry:
  %0 = load i32, ptr %cnt.addr, align 4
  %cmp = icmp ult i32 2147483647, %0
  %spec.store.select = select i1 %cmp, i32 0, i32 %0
  store i32 %spec.store.select, ptr %cnt.addr, align 4
  ret i32 0
}
