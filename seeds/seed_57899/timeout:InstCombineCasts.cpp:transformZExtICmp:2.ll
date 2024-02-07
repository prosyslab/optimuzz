target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @timespec_sign(i64 %0) {
entry:
  %cmp2 = icmp slt i64 %0, 0
  %conv3 = zext i1 %cmp2 to i32
  ret i32 %conv3
}
