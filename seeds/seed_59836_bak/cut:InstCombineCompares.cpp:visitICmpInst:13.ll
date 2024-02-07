target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @set_fields(i1 %cmp112, ptr %value) {
entry:
  br i1 %cmp112, label %cond.end127, label %lor.lhs.false114

lor.lhs.false114:                                 ; preds = %entry
  store i64 0, ptr %value, align 8
  br label %cond.end127

cond.end127:                                      ; preds = %lor.lhs.false114, %entry
  %cond128 = phi i32 [ 1, %lor.lhs.false114 ], [ 0, %entry ]
  %tobool129 = icmp ne i32 %cond128, 0
  br i1 %tobool129, label %lor.lhs.false130, label %if.then133

lor.lhs.false130:                                 ; preds = %cond.end127
  %0 = load i64, ptr %value, align 8
  br label %if.then133

if.then133:                                       ; preds = %lor.lhs.false130, %cond.end127
  ret void
}
