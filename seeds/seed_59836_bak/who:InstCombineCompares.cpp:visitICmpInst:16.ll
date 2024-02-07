target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printf_parse(ptr %max_width_length, i64 %0) {
entry:
  %cmp126 = icmp ult i64 %0, 1
  %spec.store.select = select i1 %cmp126, i64 1, i64 0
  store i64 %spec.store.select, ptr %max_width_length, align 8
  ret i32 0
}
