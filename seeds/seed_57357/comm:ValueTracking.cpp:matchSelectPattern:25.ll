target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @memcmp(i64)

define i32 @memcmp2() {
entry:
  %n1.addr = alloca i64, align 8
  %n2.addr = alloca i64, align 8
  %0 = load i64, ptr %n1.addr, align 8
  %1 = load i64, ptr %n2.addr, align 8
  %cmp1.not = icmp ugt i64 %0, %1
  %2 = load i64, ptr %n1.addr, align 8
  %3 = load i64, ptr %n2.addr, align 8
  %cond = select i1 %cmp1.not, i64 %3, i64 %2
  %call = call i32 @memcmp(i64 %cond)
  ret i32 0
}
