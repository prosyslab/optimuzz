target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @slirp_fmt(i64 %0, ...) {
entry:
  %cmp5 = icmp ult i64 0, %0
  %cond = select i1 %cmp5, i64 1, i64 0
  %conv8 = trunc i64 %cond to i32
  ret i32 0
}
