target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i64 %0) {
entry:
  %tobool.not = icmp eq i64 %0, 0
  %cond = select i1 %tobool.not, i32 0, i32 1
  call void @exit(i32 %cond)
  unreachable
}

declare void @exit(i32)
