target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @strip_trailing_slashes(ptr %base_lim, i32 %conv) {
entry:
  %cmp = icmp ne i32 %conv, 0
  %frombool = zext i1 %cmp to i8
  store i8 %frombool, ptr %base_lim, align 1
  ret i1 false
}
