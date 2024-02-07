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

define internal void @_bc_simp_mul(ptr %prodlen, i32 %0) {
entry:
  %sub = sub nsw i32 %0, 1
  %cmp = icmp slt i32 0, %sub
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %prodlen, align 8
  br label %common.ret
}
