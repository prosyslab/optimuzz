target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @check_zipfile(ptr %h, i8 %0) {
entry:
  %conv45 = zext i8 %0 to i32
  store i32 %conv45, ptr %h, align 4
  %1 = load i32, ptr %h, align 4
  %cmp46 = icmp ne i32 %1, 0
  br i1 %cmp46, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %2 = load i32, ptr %h, align 4
  br label %common.ret
}
