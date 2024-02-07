target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @system_join()
  ret i32 0
}

define internal void @system_join() {
entry:
  %call531 = call i32 @keycmp()
  ret void
}

define internal i32 @keycmp() {
entry:
  %len1 = alloca i64, align 8
  %len2 = alloca i64, align 8
  %0 = load i64, ptr %len1, align 8
  %1 = load i64, ptr %len2, align 8
  %cmp22 = icmp slt i64 %0, %1
  %2 = load i64, ptr %len1, align 8
  %3 = load i64, ptr %len2, align 8
  %cond23 = select i1 %cmp22, i64 %2, i64 %3
  %call = call i32 @memcasecmp(i64 %cond23)
  ret i32 0
}

declare i32 @memcasecmp(i64)
