target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printShapeRec(ptr %lineStyle, i32 %0, i1 %cmp10) {
entry:
  %cmp8 = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp8, i1 %cmp10, i1 false
  br i1 %or.cond, label %land.lhs.true11, label %common.ret

common.ret:                                       ; preds = %land.lhs.true11, %entry
  ret i32 0

land.lhs.true11:                                  ; preds = %entry
  %1 = load i32, ptr %lineStyle, align 4
  br label %common.ret
}
