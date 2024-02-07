target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @video_blit() {
entry:
  call void @_blit11(i32 0)
  ret void
}

define internal void @_blit11(i32 %0) {
entry:
  %rem = urem i32 %0, 8
  call void @make_mouseline(i32 %rem)
  ret void
}

declare void @make_mouseline(i32)
