target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @yy_create_buffer() {
entry:
  call void @yy_init_buffer(i32 0, ptr null)
  ret ptr null
}

define internal void @yy_init_buffer(i32 %call4, ptr %b.addr) {
entry:
  %cmp5 = icmp sgt i32 %call4, 0
  %conv = zext i1 %cmp5 to i32
  store i32 %conv, ptr %b.addr, align 4
  ret void
}
