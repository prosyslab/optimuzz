target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printTIF(ptr %ns, i32 %0) {
entry:
  %cmp110 = icmp ult i32 0, %0
  br i1 %cmp110, label %for.body, label %for.end

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %ns, align 8
  br label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}
