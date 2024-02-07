target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @readbuf(i32)

define i32 @do_string() {
entry:
  %comment_bytes_left = alloca i32, align 4
  %0 = load i32, ptr %comment_bytes_left, align 4
  %cmp2 = icmp ugt i32 %0, 65536
  %1 = load i32, ptr %comment_bytes_left, align 4
  %cond = select i1 %cmp2, i32 65536, i32 %1
  %call = call i32 @readbuf(i32 %cond)
  ret i32 0
}
