target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printShapeRec(ptr %newStyles, i1 %cmp7, i1 %cmp8) {
entry:
  %or.cond1 = select i1 %cmp8, i1 %cmp7, i1 false
  br i1 %or.cond1, label %land.lhs.true11, label %if.end

land.lhs.true11:                                  ; preds = %entry
  %0 = load i32, ptr %newStyles, align 4
  br label %if.end

if.end:                                           ; preds = %land.lhs.true11, %entry
  ret i32 0
}
