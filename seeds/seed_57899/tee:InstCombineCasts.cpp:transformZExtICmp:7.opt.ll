; ModuleID = 'seeds/seed_57899/tee:InstCombineCasts.cpp:transformZExtICmp:7.ll'
source_filename = "seeds/seed_57899/tee:InstCombineCasts.cpp:transformZExtICmp:7.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @isapipe(ptr %st, i1 %cmp1, i1 %tobool) {
entry:
  br i1 %cmp1, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  br i1 %tobool, label %cond.true, label %cond.end

cond.true:                                        ; preds = %land.rhs
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %land.rhs
  %cond = phi i32 [ 1, %cond.true ], [ 0, %land.rhs ]
  br label %land.end

land.end:                                         ; preds = %cond.end, %entry
  %0 = phi i32 [ 0, %entry ], [ %cond, %cond.end ]
  store i32 %0, ptr %st, align 4
  ret i32 0
}
