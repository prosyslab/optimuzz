target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @parse_tab_stops(i1 %cmp51, ptr %tabval) {
entry:
  br i1 %cmp51, label %cond.end, label %lor.lhs.false53

lor.lhs.false53:                                  ; preds = %entry
  store i64 0, ptr %tabval, align 8
  br label %cond.end

cond.end:                                         ; preds = %lor.lhs.false53, %entry
  %cond = phi i32 [ 1, %lor.lhs.false53 ], [ 0, %entry ]
  %tobool64 = icmp ne i32 %cond, 0
  br i1 %tobool64, label %if.end71, label %if.then65

if.then65:                                        ; preds = %cond.end
  %0 = load ptr, ptr %tabval, align 8
  br label %if.end71

if.end71:                                         ; preds = %if.then65, %cond.end
  ret void
}
