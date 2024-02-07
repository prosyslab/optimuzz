target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @__ctype_b_loc()

define ptr @trim2(ptr %d, ptr %add.ptr71) {
entry:
  %add.ptr72 = getelementptr i8, ptr %add.ptr71, i64 -1
  %cmp74.not = icmp ult ptr %add.ptr72, %d
  br i1 %cmp74.not, label %for.body85, label %land.rhs76

land.rhs76:                                       ; preds = %entry
  %call77 = call ptr @__ctype_b_loc()
  br label %for.body85

for.body85:                                       ; preds = %land.rhs76, %entry
  ret ptr null
}
