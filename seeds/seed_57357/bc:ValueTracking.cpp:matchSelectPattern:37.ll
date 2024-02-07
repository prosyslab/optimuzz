target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @bc_new_num(i32)

define void @bc_sub() {
entry:
  %call1 = call ptr @_bc_do_add(i32 0)
  ret void
}

define internal ptr @_bc_do_add(i32 %0) {
entry:
  %cmp12 = icmp slt i32 %0, 0
  %cond16 = select i1 %cmp12, i32 1, i32 0
  %call = call ptr @bc_new_num(i32 %cond16)
  ret ptr null
}
