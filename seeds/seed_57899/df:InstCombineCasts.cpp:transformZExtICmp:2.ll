target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @get_fs_usage(ptr %fsd, i64 %0) {
entry:
  %and28 = and i64 %0, -9223372036854775808
  %cmp29 = icmp ne i64 %and28, 0
  %frombool31 = zext i1 %cmp29 to i8
  store i8 %frombool31, ptr %fsd, align 8
  ret i32 0
}
