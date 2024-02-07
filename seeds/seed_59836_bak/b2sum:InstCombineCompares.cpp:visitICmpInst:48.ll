target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @blake2b_update() {
entry:
  call void @blake2b_increment_counter(ptr null, i64 0)
  ret i32 0
}

define internal void @blake2b_increment_counter(ptr %inc.addr, i64 %0) {
entry:
  %1 = xor i64 %0, -1
  %cmp = icmp ult i64 %1, %0
  %conv3 = zext i1 %cmp to i64
  store i64 %conv3, ptr %inc.addr, align 8
  ret void
}
