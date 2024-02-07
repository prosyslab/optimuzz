target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @compare_files()
  unreachable
}

declare void @error(i32, ...)

define internal void @compare_files() {
entry:
  call void @check_order(i32 0)
  ret void
}

define internal void @check_order(i32 %0) {
entry:
  %cmp20 = icmp eq i32 %0, 0
  %cond21 = zext i1 %cmp20 to i32
  call void (i32, ...) @error(i32 %cond21)
  ret void
}
