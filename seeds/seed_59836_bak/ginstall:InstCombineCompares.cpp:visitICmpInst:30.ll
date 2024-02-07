target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @canonicalize_filename_mode() {
entry:
  %call1 = call ptr @canonicalize_filename_mode_stk(ptr null, ptr null)
  ret ptr null
}

define internal ptr @canonicalize_filename_mode_stk(ptr %dest, ptr %0) {
entry:
  %.pre = load ptr, ptr %dest, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %add.ptr75 = getelementptr i8, ptr %0, i64 1
  %cmp76 = icmp ugt ptr %.pre, %add.ptr75
  br i1 %cmp76, label %if.then78, label %for.cond

if.then78:                                        ; preds = %for.cond
  ret ptr null
}
