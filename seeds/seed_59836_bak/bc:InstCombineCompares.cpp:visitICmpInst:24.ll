target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @bc_multiply() {
entry:
  call void @_bc_rec_mul()
  ret void
}

define internal void @_bc_rec_mul() {
entry:
  call void @_bc_simp_mul(ptr null, i32 0)
  ret void
}

define internal void @_bc_simp_mul(ptr %n2len.addr, i32 %0) {
entry:
  %sub18 = sub nsw i32 %0, 1
  %cmp19 = icmp sgt i32 0, %sub18
  br i1 %cmp19, label %cond.true20, label %common.ret

common.ret:                                       ; preds = %cond.true20, %entry
  ret void

cond.true20:                                      ; preds = %entry
  %1 = load i32, ptr %n2len.addr, align 4
  br label %common.ret
}
