target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cksum(ptr %l_util, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  store i32 %conv, ptr %l_util, align 4
  %1 = load i32, ptr %l_util, align 4
  %cmp9 = icmp sgt i32 %1, 0
  br i1 %cmp9, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %2 = load i32, ptr %l_util, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %entry
  ret i32 0
}
