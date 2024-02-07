target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_btowc(ptr %ret, i64 %0) {
entry:
  %cmp1 = icmp eq i64 %0, 0
  br i1 %cmp1, label %if.end, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i64, ptr %ret, align 8
  br label %if.end

if.end:                                           ; preds = %lor.lhs.false, %entry
  ret i32 0
}
