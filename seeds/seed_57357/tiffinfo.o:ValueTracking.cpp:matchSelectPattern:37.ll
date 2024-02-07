target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @TIFFReadSeparateStripData(ptr %row, i32 %0) {
entry:
  %cmp15 = icmp ugt i32 %0, 0
  %cond = select i1 %cmp15, i32 1, i32 0
  store i32 %cond, ptr %row, align 4
  ret void
}
