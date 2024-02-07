target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dirent = type { i64, i64, i16, i8, [256 x i8] }

define i32 @name2pid(ptr %end, ptr %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %lor.lhs.false, %while.cond, %entry
  %1 = load ptr, ptr %end, align 8
  %d_name12 = getelementptr %struct.dirent, ptr %0, i32 0, i32 4
  %cmp = icmp eq ptr %1, %d_name12
  br i1 %cmp, label %while.cond, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %while.cond
  %2 = load ptr, ptr %end, align 8
  br label %while.cond
}
