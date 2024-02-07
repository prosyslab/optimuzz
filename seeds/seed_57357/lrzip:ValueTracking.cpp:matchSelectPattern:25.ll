target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @read_stream() {
entry:
  %call1 = call i32 @fill_buffer(ptr null)
  ret i64 0
}

define internal i32 @fill_buffer(ptr %max_len) {
entry:
  %c_len = alloca i64, align 8
  %max_len1 = alloca i64, align 8
  %0 = load i64, ptr %max_len1, align 8
  %1 = load i64, ptr %c_len, align 8
  %cmp298 = icmp sgt i64 %0, %1
  %2 = load i64, ptr %max_len1, align 8
  %3 = load i64, ptr %c_len, align 8
  %cond303 = select i1 %cmp298, i64 %2, i64 %3
  store i64 %cond303, ptr %max_len, align 8
  ret i32 0
}
