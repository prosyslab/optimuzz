target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @posix2_version() {
entry:
  %v = alloca i64, align 8
  %0 = load i64, ptr %v, align 8
  %cmp7 = icmp slt i64 %0, 2147483647
  %1 = load i64, ptr %v, align 8
  %phi.cast = trunc i64 %1 to i32
  %cond = select i1 %cmp7, i32 %phi.cast, i32 2147483647
  ret i32 %cond
}
