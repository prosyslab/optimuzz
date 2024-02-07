target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @fdutimens() {
entry:
  %call1 = call i32 @validate_timespec(ptr null, i32 0)
  ret i32 0
}

define internal i32 @validate_timespec(ptr %utime_omit_count, i32 %0) {
entry:
  %cmp59 = icmp eq i32 %0, 0
  %conv = zext i1 %cmp59 to i32
  store i32 %conv, ptr %utime_omit_count, align 4
  ret i32 0
}
