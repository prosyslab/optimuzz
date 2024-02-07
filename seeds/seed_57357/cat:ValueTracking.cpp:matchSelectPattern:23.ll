target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call20 = call i64 @io_blksize(ptr null)
  ret i32 0
}

define internal i64 @io_blksize(ptr %sb) {
entry:
  %0 = load i64, ptr %sb, align 8
  %cmp27 = icmp ugt i64 %0, 4611686018427387904
  %cond31 = select i1 %cmp27, i64 4611686018427387904, i64 %0
  ret i64 %cond31
}
