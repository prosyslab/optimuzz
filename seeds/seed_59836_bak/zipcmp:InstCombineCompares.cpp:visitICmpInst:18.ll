target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @diff_output_file(ptr %size.addr, i64 %0, i1 %cmp1) {
entry:
  %cmp = icmp eq i64 %0, 0
  %or.cond = select i1 %cmp, i1 %cmp1, i1 false
  br i1 %or.cond, label %land.lhs.true2, label %common.ret

common.ret:                                       ; preds = %land.lhs.true2, %entry
  ret void

land.lhs.true2:                                   ; preds = %entry
  %1 = load ptr, ptr %size.addr, align 8
  br label %common.ret
}
