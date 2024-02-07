target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @connect_to_ip(ptr %bufsize) {
entry:
  %0 = load i32, ptr %bufsize, align 4
  %cmp56 = icmp slt i32 %0, 512
  %spec.store.select = select i1 %cmp56, i32 512, i32 %0
  store i32 %spec.store.select, ptr %bufsize, align 4
  ret i32 0
}
