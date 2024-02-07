target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @ssl_check_certificate(ptr %0, i32 %1) {
entry:
  br i1 undef, label %cond.false103, label %cond.end110

cond.false103:                                    ; preds = %entry
  %2 = load i32, ptr %0, align 4
  %cmp104 = icmp eq i32 %1, 0
  %cond109 = select i1 %cmp104, i32 0, i32 1
  br label %cond.end110

cond.end110:                                      ; preds = %cond.false103, %entry
  %cond111 = phi i32 [ %cond109, %cond.false103 ], [ 0, %entry ]
  %tobool112 = icmp ne i32 %cond111, 0
  ret i1 %tobool112
}
