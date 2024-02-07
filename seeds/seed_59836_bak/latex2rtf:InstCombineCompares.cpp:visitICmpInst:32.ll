target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @show_string(ptr %c, i1 %cmp24) {
entry:
  %spec.store.select1 = select i1 %cmp24, i8 61, i8 0
  %cmp29 = icmp eq i8 %spec.store.select1, 0
  %spec.store.select = select i1 %cmp29, i8 1, i8 0
  store i8 %spec.store.select, ptr %c, align 1
  ret void
}
