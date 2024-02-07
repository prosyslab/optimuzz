target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @quant_fsdither(ptr null, i32 0)
  ret i32 0
}

define internal void @quant_fsdither(ptr %r2, i32 %0) {
entry:
  %cmp68 = icmp sge i32 %0, 0
  %spec.store.select = select i1 %cmp68, i32 1, i32 0
  store i32 %spec.store.select, ptr %r2, align 4
  ret void
}
