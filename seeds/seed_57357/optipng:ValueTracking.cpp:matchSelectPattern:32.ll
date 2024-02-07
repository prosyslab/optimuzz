target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_write_find_filter() {
entry:
  call void @png_setup_paeth_row_only(ptr null, i32 0)
  ret void
}

define internal void @png_setup_paeth_row_only(ptr %pc, i32 %0) {
entry:
  %cmp29 = icmp slt i32 %0, 0
  %1 = load i32, ptr %pc, align 4
  %sub32 = sub nsw i32 0, %1
  %cond35 = select i1 %cmp29, i32 %sub32, i32 %1
  store i32 %cond35, ptr %pc, align 4
  ret void
}
