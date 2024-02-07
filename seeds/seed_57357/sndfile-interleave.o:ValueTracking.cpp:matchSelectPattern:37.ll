target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @interleave_double(ptr null, i32 0)
  ret i32 0
}

define internal void @interleave_double(ptr %max_read_len, i32 %0) {
entry:
  %cmp17 = icmp sgt i32 %0, 0
  %cond = select i1 %cmp17, i32 1, i32 0
  store i32 %cond, ptr %max_read_len, align 4
  ret void
}
