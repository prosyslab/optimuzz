target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @handle_key() {
entry:
  %call12 = call i32 @handle_key_global()
  ret void
}

define internal i32 @handle_key_global() {
entry:
  call void @minipop_slide(ptr null)
  ret i32 0
}

define internal void @minipop_slide(ptr %0) {
entry:
  %cv.addr = alloca i32, align 4
  %min.addr = alloca i32, align 4
  %1 = load i32, ptr %cv.addr, align 4
  %2 = load i32, ptr %min.addr, align 4
  %cmp4 = icmp slt i32 %1, %2
  %3 = load i32, ptr %min.addr, align 4
  %4 = load i32, ptr %cv.addr, align 4
  %cond = select i1 %cmp4, i32 %3, i32 %4
  store i32 %cond, ptr %0, align 16
  ret void
}
