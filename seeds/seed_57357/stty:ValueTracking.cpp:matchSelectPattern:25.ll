target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @xmax() {
entry:
  %size1.addr = alloca i64, align 8
  %size2.addr = alloca i64, align 8
  %0 = load i64, ptr %size1.addr, align 8
  %1 = load i64, ptr %size2.addr, align 8
  %cmp.not = icmp ult i64 %0, %1
  %2 = load i64, ptr %size1.addr, align 8
  %3 = load i64, ptr %size2.addr, align 8
  %cond = select i1 %cmp.not, i64 %3, i64 %2
  ret i64 %cond
}
