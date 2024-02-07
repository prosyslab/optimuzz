target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @client_switch_proxy(ptr %retval) {
entry:
  %r1 = alloca i32, align 4
  %0 = load i32, ptr %r1, align 4
  %cmp33 = icmp slt i32 %0, 0
  %1 = load i32, ptr %r1, align 4
  %cond = select i1 %cmp33, i32 %1, i32 0
  store i32 %cond, ptr %retval, align 4
  ret i32 0
}

define i64 @__archive_read_filter_seek() {
entry:
  %call1 = call i32 @client_switch_proxy(ptr null)
  ret i64 0
}
