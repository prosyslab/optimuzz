target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @fprint_off(ptr %p, ptr %buf) {
entry:
  %.pre = load ptr, ptr %p, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %add.ptr21 = getelementptr i8, ptr %buf, i64 64
  %cmp22 = icmp ult ptr %.pre, %add.ptr21
  br i1 %cmp22, label %for.cond, label %for.end

for.end:                                          ; preds = %for.cond
  ret void
}
