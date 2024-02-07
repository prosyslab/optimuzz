target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @trim(ptr %str.addr, i32 %conv2) {
entry:
  %cmp3 = icmp eq i32 0, %conv2
  br i1 %cmp3, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %0 = load ptr, ptr %str.addr, align 8
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  ret void
}
