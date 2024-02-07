target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @do_string(ptr %0, i8 %bf.load) {
entry:
  %bf.lshr = lshr i8 %bf.load, 7
  %bf.cast = zext i8 %bf.lshr to i32
  %tobool22 = icmp ne i32 %bf.cast, 0
  br i1 %tobool22, label %land.lhs.true23, label %if.then51

land.lhs.true23:                                  ; preds = %entry
  %1 = load ptr, ptr %0, align 8
  br label %if.then51

if.then51:                                        ; preds = %land.lhs.true23, %entry
  ret i32 0
}
