target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @i_ring_push(ptr %ir.addr, i32 %0) {
entry:
  %rem = urem i32 %0, 4
  store i32 %rem, ptr %ir.addr, align 4
  ret i32 0
}
