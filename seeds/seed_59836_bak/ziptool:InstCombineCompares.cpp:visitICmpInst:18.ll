target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %flags, i32 %0) {
entry:
  %cmp19 = icmp eq i32 %0, 0
  %spec.store.select = select i1 %cmp19, i32 1, i32 0
  store i32 %spec.store.select, ptr %flags, align 4
  ret i32 0
}
