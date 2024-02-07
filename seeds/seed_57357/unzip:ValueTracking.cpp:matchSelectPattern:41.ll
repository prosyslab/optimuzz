target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @inflate() {
entry:
  %call = call i32 @inflate_block()
  ret i32 0
}

define internal i32 @inflate_block() {
entry:
  %call471 = call i32 @inflate_dynamic(ptr null, i32 0, i1 false)
  ret i32 0
}

define internal i32 @inflate_dynamic(ptr %retval1, i32 %0, i1 %cmp379) {
entry:
  %spec.store.select = select i1 %cmp379, i32 0, i32 %0
  store i32 %spec.store.select, ptr %retval1, align 4
  ret i32 0
}
