target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

define ptr @extract_izvms_block() {
entry:
  %needlen.addr = alloca i32, align 4
  %usiz = alloca i32, align 4
  %0 = load i32, ptr %needlen.addr, align 4
  %1 = load i32, ptr %usiz, align 4
  %cmp5 = icmp ugt i32 %0, %1
  %2 = load i32, ptr %needlen.addr, align 4
  %3 = load i32, ptr %usiz, align 4
  %cond10 = select i1 %cmp5, i32 %2, i32 %3
  %conv11 = zext i32 %cond10 to i64
  %call12 = call ptr @malloc(i64 %conv11)
  ret ptr null
}
