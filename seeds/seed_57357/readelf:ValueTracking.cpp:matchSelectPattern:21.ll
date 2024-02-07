target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @uncompress2(ptr %stream, i64 %0) {
entry:
  %cmp6 = icmp ugt i64 %0, 4294967295
  %conv = trunc i64 %0 to i32
  %cond = select i1 %cmp6, i32 -1, i32 %conv
  store i32 %cond, ptr %stream, align 8
  ret i32 0
}
