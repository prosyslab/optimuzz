target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @bc_free_num(ptr %num.addr, i32 %0) {
entry:
  %cmp2 = icmp eq i32 %0, 0
  br i1 %cmp2, label %if.then3, label %common.ret

common.ret:                                       ; preds = %if.then3, %entry
  ret void

if.then3:                                         ; preds = %entry
  %1 = load ptr, ptr %num.addr, align 8
  br label %common.ret
}
