target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @system_join()
  ret i32 0
}

define internal void @system_join() {
entry:
  %call213 = call i1 @get_line()
  ret void
}

define internal i1 @get_line() {
entry:
  call void @check_order(ptr null)
  ret i1 false
}

define internal void @check_order(ptr %len) {
entry:
  %0 = load i64, ptr %len, align 8
  %cmp15 = icmp sgt i64 %0, 2147483647
  %cond20 = select i1 %cmp15, i64 2147483647, i64 %0
  store i64 %cond20, ptr %len, align 8
  ret void
}
