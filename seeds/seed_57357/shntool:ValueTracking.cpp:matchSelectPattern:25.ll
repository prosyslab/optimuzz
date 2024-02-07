target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @read_n_bytes(i32)

define i32 @open_input_stream() {
entry:
  %tag_size = alloca i64, align 8
  %0 = load i64, ptr %tag_size, align 8
  %cmp39 = icmp ult i64 %0, 2048
  %1 = load i64, ptr %tag_size, align 8
  %phi.cast = trunc i64 %1 to i32
  %cond = select i1 %cmp39, i32 %phi.cast, i32 2048
  %call41 = call i32 @read_n_bytes(i32 %cond)
  ret i32 0
}
