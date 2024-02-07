target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @bc_new_num(i32)

define void @bc_sub() {
entry:
  %call = call ptr @_bc_do_add()
  ret void
}

define internal ptr @_bc_do_add() {
entry:
  %scale_min.addr = alloca i32, align 4
  %sum_scale = alloca i32, align 4
  %0 = load i32, ptr %sum_scale, align 4
  %1 = load i32, ptr %scale_min.addr, align 4
  %cmp12 = icmp sgt i32 %0, %1
  %2 = load i32, ptr %sum_scale, align 4
  %3 = load i32, ptr %scale_min.addr, align 4
  %cond16 = select i1 %cmp12, i32 %2, i32 %3
  %call = call ptr @bc_new_num(i32 %cond16)
  ret ptr null
}
