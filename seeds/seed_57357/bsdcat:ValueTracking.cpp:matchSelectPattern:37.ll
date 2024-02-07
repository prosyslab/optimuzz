target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @client_switch_proxy(ptr %r1, i32 %0) {
entry:
  %cmp33 = icmp slt i32 %0, 0
  %cond = select i1 %cmp33, i32 1, i32 0
  store i32 %cond, ptr %r1, align 4
  ret i32 0
}

define i64 @__archive_read_filter_seek() {
entry:
  %call1 = call i32 @client_switch_proxy(ptr null, i32 0)
  ret i64 0
}
