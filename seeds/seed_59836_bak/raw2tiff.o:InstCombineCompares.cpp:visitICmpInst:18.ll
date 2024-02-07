target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %photometric, i16 %0) {
entry:
  %cmp196 = icmp eq i16 %0, 0
  %spec.store.select = select i1 %cmp196, i16 1, i16 0
  store i16 %spec.store.select, ptr %photometric, align 2
  ret i32 0
}
