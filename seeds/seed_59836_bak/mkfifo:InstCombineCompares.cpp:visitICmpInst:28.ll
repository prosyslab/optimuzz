target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @canonicalize_filename_mode() {
entry:
  %call1 = call ptr @canonicalize_filename_mode_stk(ptr null, ptr null)
  ret ptr null
}

define internal ptr @canonicalize_filename_mode_stk(ptr %dest, ptr %0) {
entry:
  %incdec.ptr79 = getelementptr i8, ptr %0, i32 -1
  store ptr %incdec.ptr79, ptr %dest, align 8
  %1 = load ptr, ptr %dest, align 8
  %cmp81 = icmp ugt ptr %1, null
  br i1 %cmp81, label %land.rhs83, label %for.body90

land.rhs83:                                       ; preds = %entry
  %2 = load ptr, ptr %dest, align 8
  br label %for.body90

for.body90:                                       ; preds = %land.rhs83, %entry
  ret ptr null
}
