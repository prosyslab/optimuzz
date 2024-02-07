target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @bc_sub() {
entry:
  %call1 = call ptr @_bc_do_add(ptr null, i8 0)
  ret void
}

define internal ptr @_bc_do_add(ptr %sumptr, i8 %0) {
entry:
  %conv74 = zext i8 %0 to i32
  %cmp75 = icmp sgt i32 %conv74, 0
  br i1 %cmp75, label %if.then77, label %common.ret

common.ret:                                       ; preds = %if.then77, %entry
  ret ptr null

if.then77:                                        ; preds = %entry
  store i32 0, ptr %sumptr, align 4
  br label %common.ret
}
