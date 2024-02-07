target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal() {
entry:
  %call17 = call i64 @ydhms_diff()
  ret i64 0
}

define internal i64 @ydhms_diff() {
entry:
  %call1 = call i64 @shr(i64 0)
  ret i64 0
}

define internal i64 @shr(i64 %0) {
entry:
  %cmp5 = icmp slt i64 %0, 0
  %conv6 = zext i1 %cmp5 to i32
  %conv7 = sext i32 %conv6 to i64
  ret i64 %conv7
}
