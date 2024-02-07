target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @strintcmp() {
entry:
  %call1 = call i32 @numcompare(ptr null, i64 0)
  ret i32 0
}

define internal i32 @numcompare(ptr %log_b, i64 %0) {
entry:
  %cmp143 = icmp ult i64 0, %0
  %cond = select i1 %cmp143, i32 1, i32 0
  store i32 %cond, ptr %log_b, align 4
  ret i32 0
}
