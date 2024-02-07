target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i1 %cmp55, ptr %skip_fields) {
entry:
  br i1 %cmp55, label %cond.end, label %lor.lhs.false57

lor.lhs.false57:                                  ; preds = %entry
  %0 = load i64, ptr %skip_fields, align 8
  store i64 0, ptr %skip_fields, align 8
  br label %cond.end

cond.end:                                         ; preds = %lor.lhs.false57, %entry
  %cond = phi i32 [ 1, %lor.lhs.false57 ], [ 0, %entry ]
  %tobool65 = icmp ne i32 %cond, 0
  br i1 %tobool65, label %if.end67, label %if.then66

if.then66:                                        ; preds = %cond.end
  store i64 0, ptr %skip_fields, align 8
  br label %if.end67

if.end67:                                         ; preds = %if.then66, %cond.end
  ret i32 0
}
