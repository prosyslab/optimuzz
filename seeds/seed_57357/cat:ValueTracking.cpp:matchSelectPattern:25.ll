target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %insize) {
entry:
  %outsize = alloca i64, align 8
  %insize1 = alloca i64, align 8
  %0 = load i64, ptr %insize1, align 8
  %1 = load i64, ptr %outsize, align 8
  %cmp116 = icmp sgt i64 %0, %1
  %2 = load i64, ptr %insize1, align 8
  %3 = load i64, ptr %outsize, align 8
  %cond121 = select i1 %cmp116, i64 %2, i64 %3
  store i64 %cond121, ptr %insize, align 8
  ret i32 0
}
