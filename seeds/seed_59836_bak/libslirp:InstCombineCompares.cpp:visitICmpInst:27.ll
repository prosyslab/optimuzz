target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@icmp_flush = internal constant [19 x i32] [i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]

define void @icmp_forward_error(ptr %icp, i64 %idxprom) {
entry:
  %arrayidx = getelementptr [19 x i32], ptr @icmp_flush, i64 0, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %tobool58 = icmp ne i32 %0, 0
  br i1 %tobool58, label %common.ret, label %if.end60

common.ret:                                       ; preds = %if.end60, %entry
  ret void

if.end60:                                         ; preds = %entry
  %1 = load ptr, ptr %icp, align 8
  br label %common.ret
}
