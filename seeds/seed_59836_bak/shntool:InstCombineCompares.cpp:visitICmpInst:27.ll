target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @prog_update(ptr %proginfo.addr, i1 %cmp6) {
entry:
  br i1 %cmp6, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %0 = load i32, ptr %proginfo.addr, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %entry
  %cond = phi i32 [ %0, %cond.true ], [ 0, %entry ]
  %cmp9 = icmp slt i32 %cond, 0
  br i1 %cmp9, label %cond.true11, label %common.ret

common.ret:                                       ; preds = %cond.true11, %cond.end
  ret void

cond.true11:                                      ; preds = %cond.end
  %1 = load ptr, ptr %proginfo.addr, align 8
  br label %common.ret
}
