target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @flush(ptr %0, i8 %bf.load) {
entry:
  %bf.lshr = lshr i8 %bf.load, 1
  %bf.cast = zext i8 %bf.lshr to i32
  %tobool4 = icmp ne i32 %bf.cast, 0
  br i1 %tobool4, label %common.ret, label %if.then5

common.ret:                                       ; preds = %if.then5, %entry
  ret i32 0

if.then5:                                         ; preds = %entry
  %1 = load i32, ptr %0, align 4
  br label %common.ret
}
