target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @xsum(i64 %0) {
entry:
  %cmp = icmp uge i64 0, %0
  %. = select i1 %cmp, i64 0, i64 1
  ret i64 %.
}
