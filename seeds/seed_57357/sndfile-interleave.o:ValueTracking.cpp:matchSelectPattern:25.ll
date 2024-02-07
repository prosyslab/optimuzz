target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @interleave_double(ptr null)
  ret i32 0
}

define internal void @interleave_double(ptr %max_read_len) {
entry:
  %max_read_len1 = alloca i32, align 4
  %read_len = alloca i32, align 4
  %0 = load i32, ptr %max_read_len1, align 4
  %1 = load i32, ptr %read_len, align 4
  %cmp17 = icmp sgt i32 %0, %1
  %2 = load i32, ptr %max_read_len1, align 4
  %3 = load i32, ptr %read_len, align 4
  %cond = select i1 %cmp17, i32 %2, i32 %3
  store i32 %cond, ptr %max_read_len, align 4
  ret void
}
