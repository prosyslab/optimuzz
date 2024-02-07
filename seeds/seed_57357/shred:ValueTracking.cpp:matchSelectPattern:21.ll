target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @randread_new() {
entry:
  %bytes_bound.addr = alloca i64, align 8
  %0 = load i64, ptr %bytes_bound.addr, align 8
  %cmp9 = icmp ugt i64 %0, 4096
  %1 = load i64, ptr %bytes_bound.addr, align 8
  %cond = select i1 %cmp9, i64 4096, i64 %1
  %call10 = call i32 @setvbuf(i64 %cond)
  ret ptr null
}

declare i32 @setvbuf(i64)
