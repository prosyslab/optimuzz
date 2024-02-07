target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @bc_new_num(ptr %_bc_Free_list) {
entry:
  %cmp = icmp ne ptr %_bc_Free_list, null
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %_bc_Free_list, align 8
  br label %common.ret
}
