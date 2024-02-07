target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @close_and_wait(i32 %0) {
entry:
  %conv48 = trunc i32 %0 to i8
  %conv49 = sext i8 %conv48 to i32
  %cmp51 = icmp sgt i32 %conv49, 0
  %conv52 = zext i1 %cmp51 to i32
  call void (ptr, i32, ptr, ...) @st_snprintf(ptr null, i32 0, ptr null, i32 %conv52)
  ret i32 0
}

declare void @st_snprintf(ptr, i32, ptr, ...)
