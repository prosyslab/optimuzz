target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %compression, i16 %0, i1 %cmp196) {
entry:
  %spec.store.select = select i1 %cmp196, i16 0, i16 %0
  store i16 %spec.store.select, ptr %compression, align 2
  ret i32 0
}
