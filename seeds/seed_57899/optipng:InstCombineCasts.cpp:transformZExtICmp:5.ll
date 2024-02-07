target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_init_read_transformations() {
entry:
  call void @png_init_rgb_transformations(ptr null, i32 0)
  ret void
}

define internal void @png_init_rgb_transformations(ptr %png_ptr.addr, i32 %conv) {
entry:
  %and = and i32 %conv, 4
  %cmp = icmp ne i32 %and, 0
  %conv1 = zext i1 %cmp to i32
  store i32 %conv1, ptr %png_ptr.addr, align 4
  ret void
}
