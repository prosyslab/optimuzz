target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @isapipe(ptr %st, i1 %cmp1, i1 %tobool) {
entry:
  br i1 %cmp1, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  br i1 %tobool, label %cond.true, label %cond.end

cond.true:                                        ; preds = %land.rhs
  %and = and i32 0, 0
  %cmp2 = icmp eq i32 0, 0
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %land.rhs
  %cond = phi i32 [ 1, %cond.true ], [ 0, %land.rhs ]
  %tobool7 = icmp ne i32 %cond, 0
  br label %land.end

land.end:                                         ; preds = %cond.end, %entry
  %0 = phi i1 [ false, %entry ], [ %tobool7, %cond.end ]
  %land.ext = zext i1 %0 to i32
  store i32 %land.ext, ptr %st, align 4
  ret i32 0
}
