target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @bc_num2long(ptr %val) {
entry:
  %0 = load i64, ptr %val, align 8
  %cmp4 = icmp slt i64 %0, 0
  %spec.store.select = select i1 %cmp4, i64 0, i64 %0
  store i64 %spec.store.select, ptr %val, align 8
  ret i64 0
}
