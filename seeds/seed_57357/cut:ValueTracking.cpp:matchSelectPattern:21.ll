target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @freadseek() {
entry:
  %offset.addr = alloca i64, align 8
  %0 = load i64, ptr %offset.addr, align 8
  %cmp30 = icmp ugt i64 %0, 4096
  %1 = load i64, ptr %offset.addr, align 8
  %cond34 = select i1 %cmp30, i64 4096, i64 %1
  %call35 = call i64 @fread(i64 %cond34)
  ret i32 0
}

declare i64 @fread(i64)
