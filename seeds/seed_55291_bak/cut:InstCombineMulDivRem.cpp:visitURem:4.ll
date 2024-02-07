target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @memchr2(ptr %void_ptr, ptr %0, i64 %1) {
entry:
  %void_ptr1 = alloca ptr, align 8
  br label %if.end

if.end:                                           ; preds = %entry
  br label %for.cond

for.cond:                                         ; preds = %if.end
  br i1 true, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond
  %2 = load ptr, ptr %void_ptr, align 8
  %3 = ptrtoint ptr %void_ptr to i64
  %rem = urem i64 %1, 8
  %cmp8 = icmp ne i64 %rem, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond
  %4 = phi i1 [ false, %for.cond ], [ %cmp8, %land.rhs ]
  br i1 %4, label %for.body, label %for.end

for.body:                                         ; preds = %land.end
  %5 = load ptr, ptr undef, align 8
  ret ptr undef

for.end:                                          ; preds = %land.end
  ret ptr undef
}
